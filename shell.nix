{ nixpkgs ? import <nixpkgs> {} }:
let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages;
  ghcPackages = haskellPackages.ghcWithPackages (p: with p; [
     aeson
     servant
     servant-server
  ]);
  project = import ./release.nix;
in
pkgs.mkShell {
  buildInputs = project.env.nativeBuildInputs ++ [
    haskellPackages.cabal-install
    pkgs.zlib
  ];
  LC_ALL = "en_US.UTF-8";
  shellHook = ''
     export NIX_GHC="${ghcPackages}/bin/ghc"
     export NIX_GHCPKGS="${ghcPackages}]bin/ghc-pkg"
     export NIX_GHC_LIBDIR=$( $NIX_GHC --print-libdir )
  '';
}
