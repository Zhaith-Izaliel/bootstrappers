{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = inputs @ {flake-parts, ...}: let
    name = "zig-bootstrapper"; # BOOTSTRAPPER: Rename this to your package name
    version = "0.0.0";
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = ["x86_64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {pkgs, ...}: {
        devShells = {
          # nix develop
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              zig
              zls
            ];
          };
        };

        packages = {
          default = pkgs.callPackage ./nix {inherit version name;};
        };
      };
    });
}
