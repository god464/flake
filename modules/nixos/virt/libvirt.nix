{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.virtual'.libvirt;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.virtual'.libvirt.enable = mkEnableOption "libvirt";
  config = mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
    programs.virt-manager.enable = true;
    environment.systemPackages = [ pkgs.dnsmasq ];
    networking = {
      nat = {
        enable = true;
        enableIPv6 = true;
        internalInterfaces = [ "virbr0" ];
      };
      firewall.trustedInterfaces = [ "virbr0" ];
    };
  };
}
