{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/25.05";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} ({...}: {
      flake = {
        templates = {
          bevy = {
            description = "A simple Bevy bootstrapper.";
            path = ./bevy;
          };

          c-makefile = {
            description = "A complete bootstrapper for C and C++ project using a simple recursive Makefile.";
            path = ./c;
          };

          godot = {
            description = "A simple Godot bootstrapper.";
            path = ./godot;
          };

          haskell = {
            description = "A batteries-included Haskell project template for Nix, based on https://github.com/srid/haskell-template";
            path = ./haskell;
          };

          rust = {
            description = "A Rust bootstrapper for any rust projects.";
            path = ./rust;
          };

          typescript = {
            description = "A NodeJS app + Typescript bootstrapper.";
            path = ./typescript;
          };

          vue = {
            description = "An opinionated bootstrapper to create a Vue.js application, with first class Typescript support, powered by Vite.js.";
            path = ./vue-typescript;
          };

          zig = {
            description = "A simple Zig bootstrapper.";
            path = ./zig;
          };
        };
      };
    });
}
