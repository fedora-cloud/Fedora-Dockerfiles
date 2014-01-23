FROM fedora
MAINTAINER "Jason Clark" <jclark@redhat.com>

RUN yum -y update
RUN yum -y install npm

ADD . /src

RUN cd /src; npm install

EXPOSE 8080

CMD ["node", "/src/index.js"]