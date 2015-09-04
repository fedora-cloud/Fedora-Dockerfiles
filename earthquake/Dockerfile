# Based on the Fedora image
FROM fedora

MAINTAINER http://fedoraproject.org/wiki/Cloud

# install main packages:
RUN dnf -y update && dnf clean all
RUN dnf -y install openssl-devel openssl readline readline-devel gcc gcc-c++ rubygems rubygems-devel ruby ruby-devel && dnf clean all

# install earthquake
RUN gem install earthquake

# set the env:
RUN useradd -d /home/twitter twitter
USER twitter 
ENV HOME /home/twitter
WORKDIR /home/twitter

CMD ["earthquake"]
