{ pkgs, ... }: {
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
  };
  programs = {
    firefox = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisablePocket = true;
        NoDefaultBookmarks = true;
      };
      nativeMessagingHosts.packages = with pkgs; [ tridactyl-native ];
    };
    thunderbird = {
      enable = true;
      policies.DisableAppUpdate = true;
    };
  };
}
