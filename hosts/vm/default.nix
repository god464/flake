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
    vcpu = 4;
    mem = 4096;
    interfaces = [
      {
        type = "tap";
        id = "microvm";
        mac = "02:00:00:00:00:01";
      }
    ];
  };
}
