dockerfiles-fedora-ansible
==========================


Built on : Docker version 1.9.1
Run on: Docker version 1.9.1
Tested on : Docker version 1.9.1

A `Dockerfile` which installs [ansible](http://www.ansible.com/docker) into
a [base Fedora](https://registry.hub.docker.com/_/fedora/) image. Base your own
docker images on this one and use ansible playbooks and
[roles](https://galaxy.ansible.com/explore#/) to configure your image instead of
snippets of shell in your Dockerfile. For example:

    FROM fedora/ansible:latest
    MAINTAINER your-good-self

    ADD tasks /etc/ansible/roles/my-role-name/tasks/
    ADD my-playbook.yml /etc/ansible/

    RUN ansible-playbook -v /etc/ansible/my-playbook.yml

Where `my-playbook.yml` might look something like this:

    ---

    - hosts:
        - localhost
      gather_facts: no
      sudo: no

      roles:
        - my-role-name

      post_tasks:

        - name: cleanup dnf cache
          command: dnf clean all

Now you can use the same code in the playbook/role to configure bare-metal
machines and also docker images.

You can build this image yourself:

    $ sudo docker build -t <username>/ansible .
