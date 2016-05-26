# Provisioning

Install Docker by following instructions from [http://docs.docker.com/engine/installation/](http://docs.docker.com/engine/installation/)

Install Docker Compose by following instructions from [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

## Pre-requisites

* docker-engine 1.10+
* docker-compose 1.6+

## Launch environment

```
docker-compose up -d
```

Chaos will be accessible using port 80 of the ws container.

## Testing

Test features using Nose and Lettuce

```
docker-compose run --rm ws /bin/bash /var/www/Chaos/docker/run-tests.sh
```

## FAQ

**How to connect to PostgreSQL running container?**

Execute the following command

```
# Use '%~`4cj,|@snhg!'f@ay~' as password (without surrounding single quote)
psql --username postgres --password -h 127.0.0.1 chaos
```

```
# Use 'AGPXSnTFHmXknK' as password (without surrounding single quote)
psql --username navitia --password -h 127.0.0.1 chaos
```

**How to remove the PostgreSQL container**

Remove postgres container

```
sudo docker rm -f `sudo docker ps -a | grep postgres | awk '{print $1}'`
```

Remove logs and database files

```
/bin/bash -c 'sudo rm -rf provisioning/postgresql/{logs,data}'
```

**How to access PostgresSQL container logs?**

Execute `Docker logs` command with `follow` (`-f`) option

```
sudo docker logs -f `sudo docker ps -a | grep postgres | awk '{print $1}'`
```

**How to build Chaos application image?**

```
(cd provisioning/app && sudo docker build -t chaos .)
```

**How to run Chaos application image?**

After having executed the command to run manually the PostgreSQL container,
run the next commands in order to
 * export development `navitia` password
 * run an application container

```
export NAVITIA_PASSWORD=AGPXSnTFHmXknK
sudo docker run \
--net=provisioning \
-e PGPASSWORD=$NAVITIA_PASSWORD \
-v `pwd`:/var/www/chaos \
-d -p 5000:5000 chaos
```

