{
  description = "Python development environment Nix managed dependencies.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };
  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { ... }:
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
          "x86_64-darwin"
        ];

        perSystem =
          { pkgs, ... }:
          {
            devShells = {
              # nix develop
              default =
                let
                  python = pkgs.python3;
                in
                pkgs.mkShell {
                  packages = [
                    python
                    python.pkgs.python-lsp-server
                  ];
                };
            };
          };
      }
    );
}
