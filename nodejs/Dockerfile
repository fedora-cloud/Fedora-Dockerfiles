FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

# ATOMIC CLI run command
LABEL RUN='docker run -d -p 8080:8080 $IMAGE'

# Install nodejs and npm
RUN dnf -y update && dnf -y install npm && dnf clean all

# Show nodejs and npm versions installed
RUN node -v
RUN npm -v

# Set port for nodejs to listen on and expose it
ENV PORT 8080
EXPOSE 8080

# Set production environment for nodejs application
ENV NODE_ENV=production \
    PATH=/src/node_modules/.bin/:$PATH

# Make directory for our nodejs project
RUN mkdir /src

# Inject package.json into directory and install all dependencies required
# to be cached in order of making future builds faster
ADD package.json /src
RUN cd /src; npm install

# Add code of our nodejs project with respect to gitignore
ADD . /src

# Run it!
CMD ["node", "/src/index.js"]
