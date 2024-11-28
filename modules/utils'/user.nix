{ config, ... }:
{
  users.mutableUsers = false;
  services.userborn.enable = config.system.etc.overlay.enable;
}
