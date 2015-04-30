dockerfiles-fedora-pdftk
========================

This repo contains a recipe for making Docker container for pdftk on Fedora 20. 
pdftk was last packaged for Fedora 20 and thus we can't get the softare in later
releases (as of 05/2014). Thus we can utilize containers to still run the older 
software. This has been tested with docker 1.6.0 

Check your Docker version

    # docker version

Perform the build

    # docker build -t <yourname>/pdftk .

Check the image out.

    # docker images

Set up an alias for pdftk:
    # alias pdftk='docker run -it --privileged -v $PWD:/workdir -w /workdir/ <yourname>/pdftk'

CD to where the files are and run it:

    # cd /path/to/files
    # pdftk A=pdf1.pdf B=pdf2.pdf cat A B output pdf12.pdf

Now pdf12.pdf should be in your current directory.

