FROM docker.io/fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

# RUN label is for atomic cli, allows for ease of use
LABEL RUN='docker run -d -p 5901:5901 -v /etc/machine-id:/etc/machine-id:ro $IMAGE'

# Install the appropriate software
RUN dnf -y update && \
    dnf -y install firefox \
                   xorg-x11-twm \
                   tigervnc-server \
                   xterm xulrunner \
                   dejavu-sans-fonts  \
                   dejavu-serif-fonts \
                   xdotool && \
    dnf clean all

# Add the xstartup file into the image and set the default password.
RUN mkdir /root/.vnc
ADD ./xstartup /root/.vnc/
RUN chmod -v +x /root/.vnc/xstartup
RUN echo 123456 | vncpasswd -f > /root/.vnc/passwd
RUN chmod -v 600 /root/.vnc/passwd

RUN sed -i '/\/etc\/X11\/xinit\/xinitrc-common/a [ -x /usr/bin/firefox ] && /usr/bin/firefox &' /etc/X11/xinit/xinitrc

EXPOSE 5901

CMD    ["vncserver", "-fg" ]
# ENTRYPOINT ["vncserver", "-fg" ]
