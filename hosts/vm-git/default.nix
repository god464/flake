{
  network'.net.name = "git";
  users.users.root.password = "";
  services'.ssh = {
    enable = true;
    hostKey = "/etc/ssh/ssh_host_ed25519_key";
  };
  microvm = {
    mem = 2048;
    vcpu = 2;
    hypervisor = "cloud-hypervisor";
  };
  services.btrfs.autoScrub.enable = false;
  web'.app.forgejo.enable = true;
}
