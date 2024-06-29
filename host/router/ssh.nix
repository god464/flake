{
  services = {
    openssh = {
      enable = true;
      startWhenNeeded = true;
      openFirewall = false;
      settings.PermitRootLogin = "no";
    };
  };
}
