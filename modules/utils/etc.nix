{ config, ... }:
{
  system.etc.overlay =
    let
      needMut = x: builtins.elem x [ "desktop" ];
    in
    {
      enable = true;
      mutable = needMut config.network'.net.name;
    };
}
