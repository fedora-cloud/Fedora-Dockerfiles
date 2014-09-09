FROM fedora
MAINTAINER "Aditya Patawari" <adimania@fedoraproject.org>

RUN yum -y update && yum clean all
RUN yum -y install python-pip && yum clean all

ADD . /src

RUN cd /src; pip install -r requirements.txt

EXPOSE 8080

CMD ["python", "/src/index.py"]
