{
  osConfig,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = osConfig.programs.niri;
in
{
  programs.noctalia-shell = lib.mkIf cfg.enable {
    enable = true;
    package = inputs.noctalia.packages."x86_64-linux".default.override {
      inherit (inputs.quickshell.packages."x86_64-linux") quickshell;
      wl-clipboard = pkgs.wl-clipboard-rs;
      calendarSupport = true;
    };
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states.polkit-agent = {
        enabled = true;
        sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
      };
      version = 2;
    };
  };
}
