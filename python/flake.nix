{
  description = "Python development environment with `uv` for ad-hoc dependencies.";

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
                  # Compiled Python wheels (numpy, scipy, etc.) expect libraries
                  # at FHS paths that don't exist on NixOS. Point the dynamic
                  # linker at the nixpkgs-provided copies instead.
                  libPath = pkgs.lib.makeLibraryPath [
                    pkgs.stdenv.cc.cc.lib
                    pkgs.zlib
                  ];
                  python = pkgs.python3;
                in
                pkgs.mkShell {
                  packages = [
                    pkgs.uv
                    python
                    python.pkgs.python-lsp-server
                  ];

                  shellHook = ''
                    export LD_LIBRARY_PATH="${libPath}:$LD_LIBRARY_PATH"
                  '';

                };
            };
          };
      }
    );
}
