{ mkDerivation, aeson, base, containers, servant, servant-server
, stdenv, warp, zlib
}:
mkDerivation {
  pname = "beam-servant-tutorial";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ aeson base ];
  executableHaskellDepends = [
    aeson base containers servant servant-server warp
  ];
  executableSystemDepends = [zlib];
  doHaddock = false;
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
