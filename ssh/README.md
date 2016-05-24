# dockerfiles-fedora-ssh

## Building

Copy the sources to your docker host and build the container:

	# docker build --rm -t <username>/ssh .

## Running

You can run the image on the registry without rebuilding with the following 
command. By default, it will bind port 2200 on the host to 22 within the container.

```
# sudo atomic run docker.io/fedora/ssh
```

To run the container, binding to port 2200 on the host:
```
# docker run --name ssh -d -p 2200:22 <username>/ssh
```
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
