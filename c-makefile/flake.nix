{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = inputs @ {flake-parts, ...}: let
    version = "1.0.0"; # BOOTSTRAPPER: Change it for your version number
    name = "c-bootstrapper"; # BOOTSTRAPPER: Change it for your package name
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = ["x86_64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {pkgs, ...}: {
        devShells = {
          # nix develop
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              valgrind
              lldb
              gnumake
              bear
              ccls
            ];
          };
        };

        packages = {
          default = pkgs.callPackage ./nix {inherit version name;};
        };
      };
    });
}
