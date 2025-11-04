{
  buildNpmPackage,
  importNpmLock,
  name,
  version,
  lib,
  electron,
}:
buildNpmPackage {
  inherit version;
  pname = name;

  src = lib.cleanSource ../.;

  npmDeps = importNpmLock {
    npmRoot = lib.cleanSource ../.;
  };

  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
  };

  nativeBuildInputs = [
    electron
  ];

  npmConfigHook = importNpmLock.npmConfigHook;

  postInstall = ''
    mkdir -p $out
    cp -r out $out
    mkdir -p $out/bin
    makeWrapper ${electron}/bin/electron $out/bin/${name} \
      --add-flags $out/out/main/index.js
  '';
}
