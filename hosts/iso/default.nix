{ pkgs, ... }:
{
  network'.net.name = "livecd";
  programs'.fish.enable = true;
  programs.git.enable = true;
  users.users.root.shell = pkgs.fish;
  hardware = {
    enableAllFirmware = true;
    enableAllHardware = true;
  };
  services.btrfs.autoScrub.enable = false;
}
