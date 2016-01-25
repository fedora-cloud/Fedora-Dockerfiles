# -*- coding: UTF-8 -*-
from behave import when, then, given
from time import sleep
from common_steps import common_docker_steps, common_connection_steps


@when(u'mysql container is started')
def mysql_container_is_started(context):
    # Read mysql params from context var
    context.execute_steps(u'* Docker container is started with params " --privileged=true --name=ctf"')
    sleep(10)


@then(u'mysql connection can be established')
@then(u'mysql connection can {action:w} be established')
@then(u'mysql connection with parameters can be established')
@then(u'mysql connection with parameters can {action:w} be established')
def mysql_connect(context, action=False):
    if context.table:
        for row in context.table:
            context.mysql[row['param']] = row['value']

    user = context.mysql['MYSQL_USER']
    password = context.mysql['MYSQL_PASSWORD']
    db = context.mysql['MYSQL_DATABASE']

    context.execute_steps(u'* port 3306 is open')

    for attempts in xrange(0, 5):
        try:
            context.run('docker run --rm -i --volumes-from=ctf %s mysql -u"%s" -p"%s" -e "SELECT 1;" %s' % (
                context.image, user, password, db))
            return
        except AssertionError:
            # If  negative part was set, then we expect a bad code
            # This enables steps like "can not be established"
            if action != 'can':
                return
            sleep(5)

    raise Exception("Failed to connect to mysql")
