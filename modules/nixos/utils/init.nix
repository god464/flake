{ config, ... }:
{
  system = {
    nixos-init.enable = config.boot.postBootCommands == "";
    activatable = false;
  };
  environment.etc."nixos".text = "";
}
