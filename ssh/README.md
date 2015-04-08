# dockerfiles-fedora-ssh

## Building

Copy the sources to your docker host and build the container:

	# docker build --rm -t <username>/ssh .

## Running

To run the container, binding to port 2200 on the host:

    # docker run --name ssh -d -p 2200:22 <username>/ssh

This will create a user named `user` with a randomly generated
password.  You can obtain the password via `docker logs`:

    # docker logs ssh | grep 'ssh user password'
    ssh user password: O2WXqqQ1CWwXHxrLZGip

You can set a specific password using the `SSH_USERPASS` environment
variable:

    # docker run --name ssh -d -p 2200:22 \
      -e SSH_USERPASS=secret <username>/ssh

To connect to this container:

    # ssh -p 2200 user@localhost
    user@localhost's password: 
    [user@d3a244022ca5 ~]$ 

