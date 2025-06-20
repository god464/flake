{ pkgs, ... }:
{
  imports = [ ./disk.nix ];
  network'.net.name = "livecd";
  programs'.fish.enable = true;
  programs.git.enable = true;
  users.users.root = {
    shell = pkgs.fish;
    initialPassword = "a";
  };
  hardware = {
    enableAllFirmware = true;
    enableAllHardware = true;
  };
}
