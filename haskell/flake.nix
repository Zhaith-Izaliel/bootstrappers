{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    haskell-flake.url = "github:srid/haskell-flake";
  };
  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [inputs.haskell-flake.flakeModule];

      perSystem = {
        pkgs,
        self',
        ...
      }: {
        haskellProjects.default = {
          projectFlakeName = "haskell-bootstrapper";
          devShell = {
            enable = true;

            # Programs you want to make available in the shell.
            # Default programs can be disabled by setting to 'null'
            tools = hp: {
              just = pkgs.just;
              hlint = hp.hlint;
            };

            # Check that haskell-language-server works
            # hlsCheck.enable = true; # Requires sandbox to be disabled
          };
        };

        # haskell-flake doesn't set the default package, but you can do it here.
        packages.default = self'.packages.haskell-bootstrapper;
      };
    };
}
