
# Disclaimers

I am still learning nix and haskell in general, please take it with a grain of salt on everthing mentioned here.

# Environments

-   OS: MacOS 10.14.16
-   Nix: 2.3.1
-   Editor: Spacemacs - 0.300.0@26.3
-   GHC : 8.6.5
-   Cabal: 2.4.1.0
-   "IDE": haskell-ide-engine 0.13.0.0 x86\_64 ghc-8.6.5

GHC, Cabal, and haskell-ide-engine (hie) is managed via nix-shell.

# Why Nix

The last thing I want to do is to drag anyone into build tool war. If It Ain't Broke, Don't Nix it <https://www.youtube.com/watch?v=G9yiJ7d5LeI>

# Nix Basics

## Install nix

```sh
curl https://nixos.org/nix/install | sh
```

## [Upgrade nix](https://nixos.org/nix/manual/#ch-upgrading-nix)

```sh
nix-channel --update; nix-env -iA nixpkgs
```

## Uninstall nix

```shell
rm -rf /nix
```

```shell
nix-prefetch-git https://github.com/NixOS/nixpkgs.git 19.09 > nixpkgs-19-09.json
```

<https://github.com/data61/fp-course/blob/master/nix/nixpkgs.nix>

to find the current nixos versions <https://github.com/NixOS/nixpkgs-channels/branches>

# Setup a haskell+nix project with hie

## all major Haskell IDE-like efforts I am aware of

-   [haskell-ide-engine(hie)](https://github.com/haskell/haskell-ide-engine)
-   [ghcide](https://github.com/digital-asset/ghcide)
-   [dante](https://github.com/jyp/dante) (emacs plugin)
-   [ghcid](https://github.com/ndmitchell/ghcid)
-   [Leksah](https://github.com/leksah/leks) (an IDE for haskell)

Among them, I like hie the most. Currently, hie has something [issues](https://github.com/haskell/haskell-ide-engine/issues/1376) work with cabal 3. So if you want to use haskell-ide-engine, you have to use cabal 2.4.1.0 or stack (stack uses cabal 2.4.1.0 internally). We could install cabal and hie using `nix-env` with commands like:

```shell
nix-channel --add https://nixos.org/channels/nixos-19.03 nixos-19-03
nix-channel --update
nix-env -iA nixos-19-03.cabal-install
cachix use all-hies
nix-env -iA selection --arg selector 'p: { inherit (p) ghc865; }' -f https://github.com/infinisil/all-hies/tarball/master
```

But a nicer way to do is to declare these packages in our nix-shell file. It is more flexible, won't affect our global cabal version, tool like hie requires GHC which you might not want install globally. The nix-shell approach also plays well with lorri.

[install hie using nix](https://github.com/Infinisil/all-hies)

usually we need three nix files for a haskell project.

-   default.nix generated by cabal2nix, which captures our haskell deps `cabal2nix . > default.nix`

### Editor intergration

<https://github.com/haskell/haskell-ide-engine/#using-hie-with-spacemacs>

## Lorri

Lorri requires direnv. I installed direnv globally using nix.

setup <https://www.tweag.io/posts/2019-03-28-introducing-lorri.html> <https://github.com/target/lorri/tree/master/example> <https://github.com/aveltras/arohi-skeleton>

git@github.com:aveltras/arohi-skeleton.git <https://direnv.net/docs/hook.html>

you can verify cabal version by `cabal --version`

## Setup local Dev tools

[Hoogle](https://hoogle.haskell.org/)

```nix
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
```

workflow

```shell
lorri daemon &
emacs . &
```

we still need beam-servant-tutorial.cabal, b/c

```sh
unpacking sources
unpacking source archive /nix/store/nf9hhcmb9a0s6qr2y1zd3lj5d36shjyj-beam-servant-tutorial.cabal
do not know how to unpack source archive /nix/store/nf9hhcmb9a0s6qr2y1zd3lj5d36shjyj-beam-servant-tutorial.cabal
```

# [Servant Tutorial](https://haskell-servant.readthedocs.io/en/v0.8/tutorial/index.html)

Outter level we need ([warp](https://hackage.haskell.org/package/warp) package)

```haskell
import Network.Wai.Handler.Warp (run)

main :: IO ()
main = run 8081 app
```

`run :: Port -> Application -> IO ()`

[run](https://www.stackage.org/haddock/nightly-2019-11-17/warp-3.3.4/Network-Wai-Handler-Warp.html#v:run)

# [Beam Tutorial](https://tathougies.github.io/beam/tutorials/tutorial1/)

# TODO checkout [input-output-hk haskell.nix](https://input-output-hk.github.io/haskell.nix/)

# References

-   <https://blog.latukha.com/NixOS-HIE-Emacs/>
-   <https://www.youtube.com/watch?v=idU7GdlfP9Q>
-   <https://github.com/digital-asset/ghcide/issues/137>
-   <https://github.com/Gabriel439/haskell-nix>
-   <https://cah6.github.io/technology/nix-haskell-1/>
-   <https://github.com/cah6/haskell-nix-skeleton-1>
-   <https://nixos.org/nixpkgs/manual/#haskell>
