{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc865" }:

let
  inherit (nixpkgs) pkgs;
 
  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callCabal2nix "project" ./beam-servant-tutorial.cabal  {};

in
  drv
