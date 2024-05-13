{
  resolved.enable = true;
  openssh = {
    enable = true;
    startWhenNeeded = true;
    settings.PermitRootLogin = "no";
  };
  btrfs.autoScrub.enable = true;
  dbus.apparmor = "enabled";
}
