{ config, ... }:
{
  system.nixos-init.enable = config.boot.postBootCommands == "";
  environment.etc = {
    "nixos".text = "";
    "machine-id".source = "/var/lib/secrets/machine-id";
  };
}
