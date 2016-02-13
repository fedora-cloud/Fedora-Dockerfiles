FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install ghc cabal-install cabal-rpm cabal-dev\
  hscolour ghc-rpm-macros hlint\
  ghc-QuickCheck-devel\
  ghc-cereal-devel\
  ghc-hslogger-devel\
  ghc-enumerator-devel\
  ghc-HUnit-devel\
  ghc-regex-compat-devel\
  ghc-aeson-devel\
  ghc-conduit-devel\
  ghc-data-default-devel\
  ghc-resourcet-devel\
  ghc-extensible-exceptions-devel\
  ghc-lifted-base-devel\
  ghc-regex-posix-devel\
  ghc-mmorph-devel\
  ghc-void-devel\
  ghc-monad-control-devel\
  ghc-semigroups-devel\
  ghc-transformers-base-devel\
  ghc-base-unicode-symbols-devel\
  ghc-regex-base-devel\
  ghc-zlib-devel\
  ghc-attoparsec-devel\
  ghc-dlist-devel\
  ghc-vector-devel\
  ghc-primitive-devel
  ghc-unordered-containers-devel\
  ghc-random-devel\
  ghc-syb-devel\
  ghc-blaze-builder-devel\
  ghc-hashable-devel\
  ghc-network-devel\
  ghc-utf8-string-devel\
  ghc-parsec-devel\
  ghc-mtl-devel\
  ghc-text-devel\
  ghc-transformers-devel &&\
 dnf clean all

CMD [ "/bin/bash" ]
