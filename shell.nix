{ nixpkgs ? import <nixpkgs> {} }:
let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages;
  ghcPackages = haskellPackages.ghcWithPackages (p: with p; [
     aeson
  ]);

  project = import ./release.nix;
in
pkgs.mkShell {
  buildInputs = project.env.nativeBuildInputs ++ [
    haskellPackages.cabal-install
    (import (builtins.fetchTarball
      "https://github.com/hercules-ci/ghcide-nix/tarball/master"
    ) {}).ghcide-ghc865
  ];
  LC_ALL = "en_US.UTF-8";
  shellHook = ''
     export NIX_GHC="${ghcPackages}/bin/ghc"
     export NIX_GHCPKGS="${ghcPackages}]bin/ghc-pkg"
     export NIX_GHC_LIBDIR=$( $NIX_GHC --print-libdir )
  '';
}
