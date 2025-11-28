{
  description = "Godot development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = inputs @ {flake-parts, ...}: let
    version = "0.1.0"; # BOOTSTRAPPER: Change it for your version number
    name = "godot-bootstrapper"; # BOOTSTRAPPER: Change it for your package name
  in
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      systems = [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = {
        system,
        config,
        pkgs,
        lib,
        ...
      }: let
        utils = import ./nix {inherit pkgs;};
      in {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnfreePredicate = pkg:
              builtins.elem (lib.getName pkg) [
                "steam-run"
                "steam-original"
                "steam-unwrapped"
              ];
          };
        };

        apps.${name} = {
          program = config.packages.${system}.nixos_template;
        };

        packages = {
          default = config.packages.linux_template;

          nixos_template = utils.mkNixosPatch {
            inherit version;
            pname = "${name}_nixos";
            src = config.packages.linux_template;
          };

          linux_template = utils.mkGodot {
            inherit version;
            pname = "${name}_linux";
            src = ./src;
            preset = "Linux/X11"; # You need to create this preset in godot
          };

          windows_template = utils.mkGodot {
            inherit version;
            pname = "${name}_windows";
            src = ./src;
            preset = "Windows Desktop"; # You need to create this preset in godot
          };
        };

        devShells = {
          # nix develop
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              godot_4
              steam-run # IMPORTANT: use it to run your game on Wayland
            ];
          };
        };
      };
    });
}
