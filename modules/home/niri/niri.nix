{
  config,
  osConfig,
  lib,
  ...
}:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri.settings = {
      inputs.xkb.layout = "us";
      outputs."eDP-1" = {
        mode = "1920x1080@60.00";
        scale = 1.25;
      };
      layouts = {
        gap = 8;
        center-focused-column = "on-overflow";
        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
        ];
        default-column-width.proportion = 0.5;
        focus-ring.width = 2;
      };
      spawn-at-startup = [ "waybar" ];
      binds = with config.lib.niri.actions; {
        "Mod+Shift+Slash".action = show-hotkey-overlay;
        "Mod+Return".action = spawn "kitty";
        "Mod+Space".action = spawn "fuzzel";
        "Mod+Escape".action = spawn "hyprlock";
        "XF86AudioRaiseVolume" = {
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
          ];
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1-"
          ];
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          actions.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
          allow-when-locked = true;
        };
        "Mod+O" = toggle-overview { repeat = false; };
        "Mod+Q" = close-window;
        "Mod+H" = focus-column-left;
        "Mod+J" = focus-column-down;
        "Mod+K" = focus-column-up;
        "Mod+L" = focus-column-up;
        "Mod+Ctrl+H" = move-column-left;
        "Mod+Ctrl+J" = move-window-down;
        "Mod+Ctrl+K" = move-window-up;
        "Mod+Ctrl+L" = move-column-right;
        "Mod+Shift+H" = focus-monitor-left;
        "Mod+Shift+J" = focus-monitor-down;
        "Mod+Shift+K" = focus-monitor-up;
        "Mod+Shift+L" = focus-monitor-right;
        "Mod+Shift+Ctrl+H" = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J" = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K" = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L" = move-column-to-monitor-right;
        "Mod+U" = focus-workspace-down;
        "Mod+D" = focus-workspace-up;
        "Mod+Ctrl+U" = move-column-to-workspace-down;
        "Mod+Ctrl+D" = move-column-to-workspace-up;
        "Mod+Shift+U" = move-workspace-down;
        "Mod+Shift+D" = move-workspace-up;
        "Mod+WheelScrollDown" = focus-workspace-down { cooldown-ms = 150; };
        "Mod+WheelScrollUp" = focus-workspace-up { cooldown-ms = 150; };
        "Mod+Ctrl+WheelScrollDown" = move-column-to-workspace-down { cooldown-ms = 150; };
        "Mod+Ctrl+WheelScrollUp" = move-column-to-workspace-up { cooldown-ms = 150; };
        "Mod+WheelScrollRight" = focus-column-right;
        "Mod+WheelScrollLeft" = focus-column-left;
        "Mod+Ctrl+WheelScrollRight" = move-column-right;
        "Mod+Ctrl+WheelScrollLeft" = move-column-left;
        "Mod+Shift+WheelScrollDown" = focus-column-right;
        "Mod+Shift+WheelScrollUp" = focus-column-left;
        "Mod+Ctrl+Shift+WheelScrollDown" = move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp" = move-column-left;
        "Mod+1" = focus-workspace 1;
        "Mod+2" = focus-workspace 2;
        "Mod+3" = focus-workspace 3;
        "Mod+4" = focus-workspace 4;
        "Mod+5" = focus-workspace 5;
        "Mod+6" = focus-workspace 6;
        "Mod+7" = focus-workspace 7;
        "Mod+8" = focus-workspace 8;
        "Mod+9" = focus-workspace 9;
        "Mod+Ctrl+1" = move-column-to-workspace 1;
        "Mod+Ctrl+2" = move-column-to-workspace 2;
        "Mod+Ctrl+3" = move-column-to-workspace 3;
        "Mod+Ctrl+4" = move-column-to-workspace 4;
        "Mod+Ctrl+5" = move-column-to-workspace 5;
        "Mod+Ctrl+6" = move-column-to-workspace 6;
        "Mod+Ctrl+7" = move-column-to-workspace 7;
        "Mod+Ctrl+8" = move-column-to-workspace 8;
        "Mod+Ctrl+9" = move-column-to-workspace 9;
        "Mod+R" = switch-preset-column-width;
        "Mod+Shift+R" = switch-preset-window-height;
        "Mod+Ctrl+R" = reset-window-height;
        "Mod+F" = maximize-column;
        "Mod+Shift+F" = fullscreen-window;
        "Mod+Ctrl+F" = expand-column-to-available-width;
        "Mod+C" = center-column;
        "Mod+Ctrl+C" = center-visible-columns;
        "Mod+Minus" = set-column-width "-10%";
        "Mod+Equal" = set-column-width "+10%";
        "Mod+Shift+Minus" = set-window-height "-10%";
        "Mod+Shift+Equal" = set-window-height "+10%";
        "Mod+V" = toggle-window-floating;
        "Mod+Shift+V" = switch-focus-between-floating-and-tiling;
        "Mod+W" = toggle-column-tabbed-display;
        "Print" = screenshot;
        "Ctrl+Print" = screenshot-screen;
        "Alt+Print" = screenshot-window;
        "Mod+Shift+P" = power-off-monitors;
      };
    };
  };
}
