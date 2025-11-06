{
  name,
  version,
  lib,
  stdenv,
  rustPlatform,
  importNpmLock,
  cargo-tauri,
  glib-networking,
  nodejs,
  npmHooks,
  openssl,
  pkg-config,
  webkitgtk_4_1,
  flatpak-xdg-utils,
  wrapGAppsHook4,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  inherit version;

  pname = name;

  src = lib.cleanSource ../.;

  cargoLock.lockFile = ../${finalAttrs.cargoRoot}/Cargo.lock;

  npmDeps = importNpmLock {
    npmRoot = finalAttrs.src;
  };

  # npmConfigHook = importNpmLock.npmConfigHook;

  nativeBuildInputs =
    [
      # Pull in our main hook
      cargo-tauri.hook

      # Setup npm
      nodejs
      importNpmLock.npmConfigHook

      # Make sure we can find our libraries
      pkg-config
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [wrapGAppsHook4];

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [
    glib-networking # Most Tauri apps need networking
    openssl
    webkitgtk_4_1
    flatpak-xdg-utils # For building .AppImage
  ];

  # Set our Tauri source directory
  cargoRoot = "src-tauri";
  # And make sure we build there too
  buildAndTestSubdir = finalAttrs.cargoRoot;
})
