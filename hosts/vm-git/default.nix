{
  network'.net.name = "git";
  users.users.root.password = "";
  services'.ssh.enable = true;
  microvm = {
    mem = 2048;
    vcpu = 2;
    hypervisor = "cloud-hypervisor";
    interfaces = [
      {
        type = "tap";
        id = "vmnet";
      }
    ];
  };
  services.btrfs.autoScrub.enable = false;
  web'.app.forgejo.enable = true;
}
