{ config, lib, ... }:
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
  };
}
