{
  import = ./core.nix;
  environment = {
    variables.AMD_VULKAN_ICD = "RADV";
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
  services = {
    colord.enable = true;
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };
    mpd = { enable = true; };
  };
  sound = {
    enable = true;
    mediaKeys.enable = true;
    enableOSSEmulation = true;
  };
}

