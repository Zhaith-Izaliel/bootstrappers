{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    rust-overlay,
    ...
  }: let
    inherit (packageJson) version name;
    packageJson = builtins.fromJSON (builtins.readFile ./package.json);
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {
        system,
        pkgs,
        ...
      }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = [rust-overlay.overlays.default];
        };

        devShells = let
          rustVersion = "latest";
          rustToolchain = "stable";
          rust = pkgs.rust-bin.${rustToolchain}.${rustVersion}.default.override {
            extensions = [
              "rust-src" # for rust-analyzer
              "rust-analyzer"
            ];
          };
        in {
          # nix develop
          default = pkgs.mkShell rec {
            nativeBuildInputs = with pkgs; [
              pkg-config
              gobject-introspection
              rust
              nodejs
              cargo-tauri
              wrapGAppsHook4
            ];

            buildInputs = with pkgs; [
              at-spi2-atk
              atkmm
              cairo
              gdk-pixbuf
              glib
              gtk3
              harfbuzz
              librsvg
              libsoup_3
              pango
              webkitgtk_4_1
              openssl
              flatpak-xdg-utils # For building .AppImage
            ];

            RUST_SRC_PATH = "${rust}";

            GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";

            # WEBKIT_DISABLE_COMPOSITING_MODE = "1";

            LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}:$LD_LIBRARY_PATH";

            XDG_DATA_DIRS = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS";

            shellHook = ''
              alias tauri="cargo-tauri"
            '';
          };
        };

        packages = {
          default = pkgs.callPackage ./nix {inherit version name;};
        };
      };
    });
}
