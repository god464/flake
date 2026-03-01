{ lib, ... }:
{
  programs.nh = {
    enable = lib.mkDefault true;
    flake = "/home/cl/persist/flake";
  };
}
