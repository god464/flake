{ config, ... }:
{
  system.nixos-init.enable = config.boot.postBootCommands == "";
}
