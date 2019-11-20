{ nixpkgs ? import <nixpkgs> {} , compiler ? "ghc865" }:
let
  drv = import ./release.nix {inherit nixpkgs compiler;};
in
  drv.env