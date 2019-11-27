let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          project =
            haskellPackagesNew.callPackage ./beam-servant-tutorial.nix { };

          cabal-install =
            haskellPackagesNew.callPackage ./cabal.nix { };
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };
in
{
  project = pkgs.haskellPackages.project;
}
