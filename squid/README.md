dockerfiles-fedora-squid
========================

Fedora dockerfile for Squid proxy cache

To configure:

- adjust the content of squid.conf

To build:

    # docker build --rm -t <username>/squid .
    
To run:

    # docker run -d -p 3128:3128 <username>/squid
    
To test:

    #  curl -x http://localhost:3128 <url>
 



