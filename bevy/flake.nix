{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = inputs @ {flake-parts, ...}: let
    inherit (cargoToml.package) name version;
    cargoToml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {
        pkgs,
        lib,
        ...
      }: {
        devShells = {
          # nix develop
          default = pkgs.mkShell rec {
            nativeBuildInputs = with pkgs; [
              pkg-config
              rustc
              cargo
              rust-analyzer
            ];
            buildInputs = with pkgs; [
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
            LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
          };
        };

        packages = {
          default = pkgs.callPackage ./nix {inherit version name;};
        };
      };
    });
}
