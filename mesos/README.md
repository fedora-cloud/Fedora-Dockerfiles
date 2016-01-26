docker-multi-container-mesos
============================

Directories containing dockerfiles and support files for running mesos
as separate services in docker containers.

master - Files for a mesos master
slave - Files for a mesos slave

Starting the containers

The mesos master container needs to be started first, and then any number of
slave containers may be started.  The slave containers need to be linked to
the master container.  For example, if the master container was started with:

    docker run --name master -d -p 5050:5050 <username>/mesos-master

Then the slave container(s) should be started with:

    docker run --link master:mesos_master -d -p 5051:5051 <username>/mesos-slave

Note: Only 1 slave can be run on a machine with the above command because of
the port mapping.  If the slave does not need to be accessible from outside
dockers private network then remove the -p 5051:5051 and as many slaves as
desired can be started.

The part of the link option after the colon (mesos-master) must always be the
same.  That is what allows the mesos-slave container to find the mesos-master.

To access services once all the containers are started, open a local browser
and hit the following URLs.

    http://localhost:5050 - Master
