{ inputs, ... }:
{
  imports = [ inputs.microvm.nixosModules.microvm ];
  network'.net.name = "microvm";
  users.users.root.password = "";
  services = {
    btrfs.autoScrub.enable = false;
    getty.autologinUser = "root";
  };
  microvm = {
    hypervisor = "cloud-hypervisor";
    vcpu = 1;
    mem = 1024;
    interfaces = [
      {
        type = "tap";
        id = "microvm";
        mac = "02:00:00:00:00:01";
      }
    ];
  };
  web'.app.calibre.enable = true;
  system.nixos-init.enable = false;
}
