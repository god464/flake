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
    vsock.cid = 3;
    mem = 1024;
    interfaces = [
      {
        type = "tap";
        id = "microvm";
        mac = "02:00:00:00:00:01";
      }
    ];
  };
  system.nixos-init.enable = false;
  web' = {
    app = {
      immich.enable = true;
      # linkwarden.enable = true;
    };
    http.nginx.enable = true;
  };
}
