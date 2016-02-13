# Dockerfile for lapis on fedora
FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install unzip tar wget vim git make gcc readline-devel pcre-devel openssl-devel && dnf clean all

#install openresty
ENV OPENRESTY_VERSION 1.7.7.1
RUN cd /usr/src/ \
&& wget http://openresty.org/download/ngx_openresty-$OPENRESTY_VERSION.tar.gz \
&& tar xvfz ngx_openresty-$OPENRESTY_VERSION.tar.gz \
&& cd ngx_openresty-$OPENRESTY_VERSION \
&& ./configure \
&& make \
&& make install

#install luarocks
ENV LUAROCKS_VERSION 2.2.0
RUN cd /usr/src/ \
&& wget http://luarocks.org/releases/luarocks-$LUAROCKS_VERSION.tar.gz \
&& tar xvfz luarocks-$LUAROCKS_VERSION.tar.gz \
&& cd luarocks-$LUAROCKS_VERSION \
&& ./configure --prefix=/usr/local/openresty/luajit \
        --with-lua=/usr/local/openresty/luajit/ \
        --lua-suffix=jit-2.1.0-alpha \
        --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1 \
&& make build \
&& make install

ENV PATH=/usr/local/openresty/luajit/bin/:$PATH

#install lapis
RUN luarocks install lapis

# Bundle app source
#COPY . /lapisappa
ADD . /opt/webapp
WORKDIR /opt/webapp

EXPOSE 8080
# start lapis server
CMD ["lapis", "server"]
