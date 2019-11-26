{ nixpkgs ? import <nixpkgs> {} , compiler ? "ghc865" }:
let
  myPackages = (import ./release1.nix {withHoogle = true; });
   projectDrvEnv = myPackages.project1.env.overrideAttrs (oldAttrs: rec {
    buildInputs = oldAttrs.buildInputs ++ [ 
      nixpkgs.haskellPackages.cabal-install
      nixpkgs.haskellPackages.hoogle
    ];
  });
in
  projectDrvEnv
