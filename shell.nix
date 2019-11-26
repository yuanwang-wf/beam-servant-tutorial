{ nixpkgs ? import <nixpkgs> {} , compiler ? "ghc865" }:
let
  inherit (nixpkgs) haskellPackages;
  myPackages = import ./release.nix {inherit nixpkgs compiler; };
in
  haskellPackages.shellFor {
    withHoogle = true;
    packages = p: [myPackages];
    buildInputs =  with nixpkgs.haskellPackages;
     [ hlint stylish-haskell ghcid hoogle];
}
