{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc865" }:

nixpkgs.pkgs.haskell.packages.${compiler}.callCabal2nix "project" ./beam-servant-tutorial.cabal { }
