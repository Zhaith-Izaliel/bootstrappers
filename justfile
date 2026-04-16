update-flakes:
    find . -maxdepth 2 -type f -path '**/flake.nix' -exec nix flake update --flake {} \;
