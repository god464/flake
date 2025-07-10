{ inputs, ... }:
{
  imports = [ inputs.microvm.nixosModules.microvm ];
  network'.net.name = "microvm";
  users.users.root.password = "";
  microvm = {
    hypervisor = "qemu";
    vcpus = 4;
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
