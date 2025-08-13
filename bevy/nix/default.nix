{
  rustPlatform,
  udev,
  alsa-lib,
  vulkan-loader,
  xorg,
  libxkbcommon,
  wayland,
  pkg-config,
  lib,
  name,
  version,
}:
rustPlatform.buildRustPackage {
  inherit version;
  pname = name;
  cargoLock.lockFile = ../Cargo.lock;
  src = lib.cleanSource ../.;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    udev
    alsa-lib
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    libxkbcommon
    wayland
  ];
}
