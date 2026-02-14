{ lib, ... }:
{
  system.nixos-init.enable = lib.mkDefault true;
  environment.etc."nixos".text = "";
}
