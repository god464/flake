{
  network'.net.name = "test";
  users.users.root.password = "";
  services'.ssh.enable = true;
  microvm = {
    mem = 4096;
    vcpu = 2;
    hypervisor = "qemu";
    interfaces = [
      {
        type = "tap";
        id = "vmnet";
        mac = "02:00:00:00:00:01";
      }
    ];
  };
  services.btrfs.autoScrub.enable = false;
  web' = {
    http.caddy.enable = true;
    sql.postgresql.enable = true;
  };
}
