{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
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
            path = ./c-makefile;
          };

          electron-vue-typescript = {
            description = "An opinionated bootstrapper to create an Electron application with first class Vue/Typescript support, validated by ESLint.";
            path = ./electron-vue-typescript;
          };

          tauri-vue-typescript = {
            description = "An opinionated bootstrapper to create a Tauri application with first class Vue/Typescript support, validated by ESLint.";
            path = ./tauri-vue-typescript;
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
            description = "An opinionated bootstrapper to create a Typescript application, validated by ESLint.";
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
