{
  stdenv,
  zig,
  name,
  version,
}:
stdenv.mkDerivation {
  inherit version;
  pname = name;

  src = ../.;

  dontConfigure = true;

  nativeBuildInputs = [
    zig.hook
  ];

  meta = {
    mainProgram = name;
  };
}
