{ config, ... }:
{
  system.nixos-init.enable = config.boot.postBootCommands == "";
  environment.etc."nixos".text = "";
}
