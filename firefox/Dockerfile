FROM mattdm/fedora
MAINTAINER scollier <scollier@redhat.com>

RUN yum -y update
RUN yum -y install x11vnc firefox xorg-x11-server-Xvfb
RUN mkdir /root/.vnc
RUN x11vnc -storepasswd 1234 /root/.vnc/passwd
ADD ./xstartup /root/.vnc/.
RUN chmod 755 /root/.vnc/xstartup
RUN bash -c 'echo "firefox" >> /etc/bashrc'

EXPOSE 5900
CMD    ["x11vnc", "-forever", "-usepw", "-create"]
