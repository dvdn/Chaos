"""Creating "severity_wordings" table

Revision ID: 4a7d3e5439d2
Revises: 1b9a20f9a38f
Create Date: 2015-01-13 15:27:14.930623

"""

# revision identifiers, used by Alembic.
revision = '4a7d3e5439d2'
down_revision = '1b9a20f9a38f'

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql
import datetime
import uuid


def single_wording_to_multi_wording(row):
    """
    Stores existing severity wording under long key into severity_wordings table
    :param row: Severity table record
    :return: void
    """
    query = "INSERT INTO severity_wordings (id, severity_id, key, value, created_at) VALUES ('{}', '{}', '{}', '{}', '{}')"
    now = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')
    id = uuid.uuid4()

    op.execute(query.format(id, row['id'], 'long', row['wording'], now))


def multi_wording_to_single_wording(row):
    """
    Stores existing wording from severity_wordings into severity table
    :param row: severity_wordings table record
    :return: void
    """
    query = "UPDATE severity SET wording = '{}' WHERE id='{}'"
    op.execute(query.format(row['value'], row['severity_id']))


def single_wordings_to_multi_wordings():
    """
    Moves all existing severity wordings from severity table to severity_wording table
    :return: void
    """
    connection = op.get_bind()

    result = connection.execute('SELECT id, wording FROM severity')
    for row in result:
        single_wording_to_multi_wording(row)


def multi_wordings_to_single_wordings():
    """
    Moves all existing wordings from severity_wording table to severity table
    :return: void
    """
    connection = op.get_bind()

    query = 'SELECT DISTINCT ON (severity_id) severity_id, value FROM severity_wordings ORDER BY severity_id, value'
    result = connection.execute(query)
    for row in result:
        multi_wording_to_single_wording(row)


def upgrade():
    op.create_table('severity_wordings',
        sa.Column('id',         postgresql.UUID(),  nullable=False),
        sa.Column('severity_id',postgresql.UUID(),  nullable=False),
        sa.Column('key',        sa.VARCHAR(255),    nullable=False),
        sa.Column('value',      sa.Text(),          nullable=True),
        sa.Column('created_at', sa.DateTime(),      nullable=False),
        sa.Column('updated_at', sa.DateTime(),      nullable=True),

        sa.PrimaryKeyConstraint('id'),
        sa.ForeignKeyConstraint(['severity_id'], ['severity.id'],)
    )

    single_wordings_to_multi_wordings()

    op.drop_column(u'severity', 'wording')


def downgrade():
    op.add_column(u'severity', sa.Column('wording', sa.Text(), nullable=True))
    multi_wordings_to_single_wordings()
    op.drop_table('severity_wordings')
