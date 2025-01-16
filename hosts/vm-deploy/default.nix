{
  network'.net.name = "test";
  users.users.root.password = "";
  services'.ssh.enable = true;
  microvm = {
    mem = 2048;
    vcpu = 2;
    hypervisor = "qemu";
    interfaces = [
      {
        type = "tap";
        id = "vmnet";
      }
    ];
  };
  services.btrfs.autoScrub.enable = false;
  web'.http.caddy.enable = true;
}
