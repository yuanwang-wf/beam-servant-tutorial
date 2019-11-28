{ mkDerivation, aeson, base, containers, servant, servant-server
, stdenv, time, warp
}:
mkDerivation {
  pname = "beam-servant-tutorial";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base containers servant servant-server time
  ];
  executableHaskellDepends = [ base warp ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
