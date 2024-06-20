{
  resolved.enable = true;
  openssh = {
    enable = true;
    startWhenNeeded = true;
    settings.PermitRootLogin = "no";
  };
  btrfs.autoScrub.enable = true;
  dbus.apparmor = "enabled";
  /* Cost-effectiveness is too low
     beesd.filesystems = {
       root = {
         spec = "LABEL=NixOS";
         hashTableSizeMB = 4096;
       };
     };
  */
}
