dockerfiles-fedora-pandoc
=========================

This repo contains a recipe for making Docker container for pandoc on Fedora.

Perform the build

    # docker build -t <yourname>/pandoc .

Check the image out.

    # docker images

Set up an alias for pandoc:
    # alias pandoc='docker run -i --rm -v $PWD:/workdir -w /workdir/ <yourname>/pandoc'

CD to where the files are and run it:

    # cd /path/to/files
    # cat post.rst | pandoc -r rst -t html > post.html

Now post.html (the converted html file) should be in your current directory.
