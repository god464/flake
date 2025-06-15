{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        label = [
          {
            monitor = "";
            text = "$TIME12";
            position = "0, 300";
            font_size = 65;
            color = "#d3c6aa";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = ''cmd[update:60000] date +"%A, %B %d"'';
            font_size = 17;
            color = "#d3c6aa";
            position = "0, 240";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
