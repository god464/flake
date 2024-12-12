{ config, ... }:
{
  system.etc.overlay = {
    enable = true;
    mutable = config.network'.net.name != "server";
  };
}
