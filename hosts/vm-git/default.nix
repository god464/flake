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
    hypervisor = "qemu";
  };
  services.btrfs.autoScrub.enable = false;
}
