{ mkDerivation, aeson, base, beam-core, beam-migrate, beam-sqlite
, containers, servant, servant-server, sqlite-simple, stdenv, text
, time, warp
}:
mkDerivation {
  pname = "beam-servant-tutorial";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base beam-core beam-migrate beam-sqlite containers servant
    servant-server sqlite-simple text time
  ];
  executableHaskellDepends = [ base warp ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
