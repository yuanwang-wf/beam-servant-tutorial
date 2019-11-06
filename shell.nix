{ nixpkgs ? import <nixpkgs> {} }:
let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages;

  project = import ./release.nix;
in
pkgs.stdenv.mkDerivation {
  name = "shell";
  buildInputs = project.env.nativeBuildInputs ++ [
    haskellPackages.cabal-install
    (import (builtins.fetchTarball
      "https://github.com/hercules-ci/ghcide-nix/tarball/master"
    ) {}).ghcide-ghc865
  ];
  LC_ALL = "en_US.UTF-8";
  shellHook = ''
     export NIX_GHC="ghc"
     export NIX_GHCPKGS="ghc-pkg"
     export NIX_GHC_LIBDIR=$( $NIX_GHC --print-libdir )
  '';

}