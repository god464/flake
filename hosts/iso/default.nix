{ pkgs, ... }:
{
  imports = [ ./disk.nix ];
  network'.net.name = "livecd";
  services'.gpg.enable = true;
  programs'.fish.enable = true;
  desktop'.gnome.enable = true;
  users.users.guest = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    createHome = true;
    shell = pkgs.fish;
    initialPassword = "a";
  };
  hardware = {
    enableAllFirmware = true;
    cpu = {
      amd.updateMicrocode = true;
      intel.updateMicrocode = true;
    };
    amdgpu.initrd.enable = true;
    nvidia.open = true;
  };
  services.btrfs.autoScrub.fileSystems = [ "/" ];
}
