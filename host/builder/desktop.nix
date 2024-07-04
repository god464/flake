{
  services = {
    desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = false;
    };
    displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
     };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
  programs = {
    firefox = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisablePocket = true;
        NoDefaultBookmarks = true;
      };
    };
    thunderbird = {
      enable = true;
      policies.DisableAppUpdate = true;
    };
  };
  security.polkit.enable = true;
}
