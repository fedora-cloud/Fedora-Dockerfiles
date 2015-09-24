dockerfiles-fedora-django
========================

Fedora dockerfile for django

Tested on Docker 1.8.1

To build:

Copy the sources down -

    # docker build --rm -t <username>/django .


To run:

    # docker run -d -p 8000:8000 <username>/django


You can create project in current directory like this:

    # docker run -v .:/code <username>/django django-admin startproject awesome_web .


To test:

    # docker run <username>/django django-admin --version 

