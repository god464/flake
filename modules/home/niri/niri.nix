{
  pkgs,
  osConfig,
  lib,
  config,
  ...
}:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri.settings = {
      input = {
        keyboard.xkb.layout = "us";
        touchpad.accel-profile = "adaptive";
      };
      outputs."eDP-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        scale = 1.25;
      };
      layout = {
        gaps = 10;
        preset-column-widths = [
          { proportion = 0.333333; }
          { proportion = 0.5; }
          { proportion = 0.666667; }
        ];
        default-column-width.proportion = 0.5;
        focus-ring.width = 2;
      };
      prefer-no-csd = true;
      window-rules = [
        {
          matches = [ { app-id = ''r#"firefox$"# title="^Picture-in-Picture$"''; } ];
          open-floating = true;
        }
      ];
      binds = with config.lib.niri.actions; {
        "Mod+Shift+Slash".action = show-hotkey-overlay;
        "Mod+Return" = {
          hotkey-overlay.title = "Open Terminal";
          action.spawn = "kitty";
        };
        "Mod+Space" = {
          hotkey-overlay.title = "Open Launcher";
          action.spawn = "fuzzel";
        };
        "Mod+Escape" = {
          hotkey-overlay.title = "Lock Screen";
          action.spawn = "hyprlock";
        };
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "5%+"
          ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "5%-"
          ];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
        };
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn = [
            "${lib.getExe pkgs.brightnessctl}"
            "set"
            "5%+"
          ];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn = [
            "${lib.getExe pkgs.brightnessctl}"
            "set"
            "5%-"
          ];
        };
        "Mod+O".action = toggle-overview;
        "Mod+Q".action = close-window;
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+Shift+H".action = move-window-up;
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;
        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+Ctrl+F".action = expand-column-to-available-width;
        "Mod+C".action = center-column;
        "Mod+Ctrl+C".action = center-visible-columns;
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
        "Mod+W".action = toggle-column-tabbed-display;
        Print.action = screenshot;
        "Ctrl+Print".action.screenshot-screen = [ ];
        "Alt+Print".action = screenshot-window;
        "Mod+Shift+E".action = quit;
        "Mod+Shift+P".action = power-off-monitors;
      };
    };
  };
}
