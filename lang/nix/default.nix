{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter (with pkgs; [
    cachix
    statix
    vulnix
    nil
    nixfmt
    nixpkgs-fmt
    deadnix
    nixpkgs-lint
  ]);
}
