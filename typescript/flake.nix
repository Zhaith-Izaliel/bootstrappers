{
  description = "An opinionated bootstrapper to create a Typescript application, validated by ESLint.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = inputs @ {flake-parts, ...}: let
    inherit (packageJson) version name;
    packageJson = builtins.fromJSON (builtins.readFile ./package.json);
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = ["x86_64-linux" "aarch64-darwin" "x86_64-darwin"];

      perSystem = {pkgs, ...}: {
        devShells = {
          # nix develop
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              nodePackages.prettier
              nodePackages.typescript-language-server
              nodejs_22
            ];
          };
        };

        packages = {
          default = pkgs.callPackage ./nix {inherit version name;};
        };
      };
    });
}
