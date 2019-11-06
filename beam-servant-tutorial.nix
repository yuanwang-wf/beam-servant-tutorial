{ mkDerivation, aeson, base, stdenv }:
mkDerivation {
  pname = "beam-servant-tutorial";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ aeson base ];
  executableHaskellDepends = [ aeson base ];
  doHaddock = false;
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
