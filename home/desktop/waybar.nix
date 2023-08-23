{
  mainBar = {
    layer = "top";
    position = "top";
    modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
    modules-center = [ "hyprland/window" ];
    modules-right = [
      "idle_inhibitor"
      "network"
      "pulseaudio"
      "backlight"
      "battery"
      "clock"
      "tray"
    ];
    "hyprland/submap" = { "format" = ''<span style="italic">{}</span>''; };
    "network" = {
      "format-wifi" = "{essid} ({signalStrength}%) ";
      "format-ethernet" = "{ipaddr}/{cidr} ";
      "tooltip-format" = "{ifname} via {gwaddr} ";
      "format-linked" = "{ifname} (No IP) ";
      "format-disconnected" = "Disconnected ⚠";
      "format-alt" = "{ifname}: {ipaddr}/{cidr}";
    };
    "battery" = {
      "states" = {
        "warning" = 30;
        "critical" = 15;
      };
      "format" = "{capacity}% {icon}";
      "format-charging" = "{capacity}% ";
      "format-plugged" = "{capacity}% ";
      "format-alt" = "{time} {icon}";
      "format-icons" = [ "" "" "" "" "" ];
    };
    "pulseaudio" = {
      "format" = "{volume}% {icon} {format_source}";
      "format-bluetooth" = "{volume}% {icon} {format_source}";
      "format-bluetooth-muted" = " {icon} {format_source}";
      "format-muted" = " {format_source}";
      "format-source" = "{volume}% ";
      "format-source-muted" = "";
      "format-icons" = {
        "headphone" = "";
        "hands-free" = "";
        "headset" = "";
        "phone" = "";
        "portable" = "";
        "car" = "";
        "default" = [ "" "" "" ];
      };
      "on-click" = "pavucontrol";
    };

    "backlight" = {
      "format" = "{percent}% {icon}";
      "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
    };
  };
}
