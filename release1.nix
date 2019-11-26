{ withHoogle ? false
}:
let
  bootstrap = import <nixpkgs> { };

  nixpkgs = builtins.fromJSON (builtins.readFile ./nixos-19-03.json);

  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };

  pinnedPkgs = import src { };

  customHaskellPackages = pinnedPkgs.haskellPackages.override (old: {
    overrides = pinnedPkgs.lib.composeExtensions (old.overrides or (_: _: {})) (self: super: {
      project1 = self.callPackage ./default.nix { };
      # addditional overrides go here
    });
  });

  hoogleAugmentedPackages = import ./toggle-hoogle.nix {withHoogle = withHoogle; input = customHaskellPackages;};

in
{
  project1 = hoogleAugmentedPackages.project1;
}
