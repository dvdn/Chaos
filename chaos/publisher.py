from kombu import Connection, Exchange
from kombu.pools import producers
import logging
import socket
from gevent import spawn_later


class Publisher(object):
    def __init__(self, connection_string, exchange, is_active=True):
        self._is_active = is_active
        self.is_connected = True
        if not is_active:
            self.is_connected = False
            return

        self._connection = Connection(connection_string)
        self._connections = set([self._connection])  # set of connection for the heartbeat
        self._exchange = Exchange(exchange, durable=True, delivry_mode=2, type='topic')
        self._connection.connect()
        monitor_heartbeats(self._connections)

    def _get_producer(self):
        producer = producers[self._connection].acquire(block=True, timeout=2)
        self._connections.add(producer.connection)
        return producer

    def errback(self, exc, interval):
        logging.getLogger(__name__).info('Error: %r', exc, exc_info=1)
        logging.getLogger(__name__).info('Retry in %s seconds.', interval)

    def publish(self, item, contributor):
        if not self._is_active:
            logging.getLogger(__name__).info('RabbitMQ is not enabled')
            return True

        with self._get_producer() as producer:
            try:
                self.is_connected = True
                publish = producer.connection.ensure(producer, producer.publish, errback=self.errback, max_retries=3)
                publish(item, exchange=self._exchange, routing_key=contributor, declare=[self._exchange])
                logging.getLogger(__name__).info('Publishing message on exchange %s', self._exchange.name)
            except Exception, e:
                self.is_connected = False
                logging.getLogger(__name__).exception("Impossible to publish message to rabbitmq")
                logging.getLogger(__name__).exception(repr(e))
            finally:
                return self.is_connected

    def info(self):
        result = {
            "is_active": self._is_active,
            "is_connected": self.is_connected
        }
        if not self._is_active:
            return result

        with self._get_producer() as producer:
            res = producer.connection.info()
            if 'password' in res:
                del res['password']
            for key, value in res.items():
                result[key] = value
        return result


def monitor_heartbeats(connections, rate=2):
    """
    launch the heartbeat of amqp, it's mostly for prevent the f@#$ firewall from dropping the connection
    """
    supports_heartbeats = False
    interval = 10000
    for conn in connections:
        if conn.heartbeat and conn.supports_heartbeats:
            supports_heartbeats = True
            interval = min(conn.heartbeat / 2, interval)

    if not supports_heartbeats:
        logging.getLogger(__name__).info('heartbeat is not enabled')
        return
    logging.getLogger(__name__).info('start rabbitmq monitoring')

    def heartbeat_check():
        to_remove = []
        for conn in connections:
            if conn.connected:
                logging.getLogger(__name__).debug('heartbeat_check for %s', conn)
                try:
                    conn.heartbeat_check(rate=rate)
                except socket.error:
                    logging.getLogger(__name__).info('connection %s dead: closing it !', conn)
                    # actually we don't do a close(), else we won't be able to reopen it after...
                    to_remove.append(conn)
            else:
                to_remove.append(conn)
        for conn in to_remove:
            connections.remove(conn)
        spawn_later(interval, heartbeat_check)

    spawn_later(interval, heartbeat_check)
