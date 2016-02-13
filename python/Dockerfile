FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install python-pip && dnf clean all

ADD . /src

RUN cd /src; pip install -r requirements.txt

EXPOSE 8080

CMD ["python", "/src/index.py"]
