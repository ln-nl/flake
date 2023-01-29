{ pkgs, system, stdenv, lib }:

let
  nodePackages = import ./composition.nix {
    inherit pkgs system;
  };
in
nodePackages // {
}
