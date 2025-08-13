{pkgs}: {
  mkGodot = pkgs.callPackage ./mkGodot.nix {};
  mkNixosPatch = pkgs.callPackage ./mkNixosPatch.nix {};
}
