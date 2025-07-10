{ inputs, ... }:
{
  imports = [ inputs.microvm.nixosModules.microvm ];
  network'.net.name = "microvm";
  users.users.root.password = "";
  services.btrfs.autoScrub.enable = false;
  microvm = {
    hypervisor = "qemu";
    vcpu = 4;
    mem = 4096;
    interfaces = [
      {
        type = "tap";
        id = "qemu";
        mac = "00:00:00:00:00:02";
      }
    ];
  };
}
