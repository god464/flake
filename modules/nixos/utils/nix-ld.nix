{ lib, ... }:
{
  programs.nix-ld.enable = true;
  services.envfs.enable = lib.mkDefault true;
}
