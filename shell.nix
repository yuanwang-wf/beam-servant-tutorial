{ nixpkgs ? import <nixpkgs> {} , compiler ? "ghc865" }:
let
  inherit (nixpkgs) haskellPackages;
  myPackages = import ./release.nix {inherit nixpkgs compiler; };
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
  haskellPackages.shellFor {
    withHoogle = true;
    packages = p: [myPackages];
    buildInputs =  with nixpkgs.haskellPackages;
     [ hlint 
       stylish-haskell 
       ghcid 
       hoogle
       (all-hies.selection {selector = p: {inherit (p) ghc865; };}) 
     ];
}
