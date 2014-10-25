dockerfiles-fedora-haskell
========================

Fedora dockerfile for Haskell

It includes ghc, cabal-install, and various key libraries.

Get Docker version

  # docker version

To build:

Copy the sources down and do the build

  # docker build --rm -t <username>/haskell .

To test:

  # docker run -i -t <username>/haskell
