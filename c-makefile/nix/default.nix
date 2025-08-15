{
  stdenv,
  lib,
  version,
  name,
}:
stdenv.mkDerivation rec {
  inherit version name;
  src = lib.cleanSource ../.;
  buildPhase = "make";
  installPhase = ''
    mkdir -p $out/bin
    install -t $out/bin bin/a.out
    mv $out/bin/a.out $out/bin/${name}
  '';
}
