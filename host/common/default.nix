{
  imports = [ ./i18n.nix ];
  users.mutableUsers = false;
  hardware = {
    cpu.amd.updateMicrocode = true;
    amdgpu = {
      amdvlk.enable = true;
      opencl.enable = true;
    };
  };
  zramSwap.enable = true;
  services.btrfs.autoScrub.enable = true;
}
