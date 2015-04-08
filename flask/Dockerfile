FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN yum -y update && yum clean all
RUN yum -y install python-flask && yum clean all
ADD flask-example.py /opt/
EXPOSE 5000

CMD [ "/usr/bin/python", "/opt/flask-example.py" ]
