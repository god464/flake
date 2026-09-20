{
  pkgs,
  osConfig,
  lib,
  ...
}:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.niri = {
      enable = true;
      enableDefaultConfig = true;
      settings = {
        debug.honor-xdg-activation-with-invalid-serial = { };
        hotkey-overlay.skip-at-startup = { };
        input = {
          keyboard.xkb = {
            layout = "us";
            options = "caps:escape";
          };

          touchpad = {
            tap = { };
            natural-scroll = { };
            accel-profile = "adaptive";
          };
        };

        output = {
          _args = [ "eDP-1" ];
          mode._args = [ "1920x1080@60.000" ];
          scale = 1.25;
        };

        layout = {
          gaps = 10;

          preset-column-widths._children = [
            { proportion = 0.333333; }
            { proportion = 0.5; }
            { proportion = 0.666667; }
          ];

          default-column-width.proportion = 0.5;

          focus-ring.width = 2;
        };

        prefer-no-csd = { };
        _children = [
          {
            window-rule = {
              match._props = {
                app-id = "firefox$";
                title = "^Picture-in-Picture$";
              };
              open-floating = true;
              open-maximized = false;
            };
          }
          {
            window-rule = {
              geometry-corner-radius = 20;
              clip-to-geometry = true;
            };
          }
          {
            window-rule = {
              match._props.app-id = "^org\.gnome\.World\.Secrets$";
              block-out-from = "screencast";
            };
          }
          {
            layer-rule = {
              match._props.namespace = "^wallpaper$";
              place-within-backdrop = true;
            };
          }
        ];

        binds = {
          "Mod+Shift+Slash".show-hotkey-overlay = { };

          "Mod+Return" = {
            _props.hotkey-overlay-title = "Open Terminal";
            spawn = [ "ghostty" ];
          };

          "Mod+Space" = {
            _props.hotkey-overlay-title = "Open Launcher";
            spawn = [
              "noctalia"
              "msg"
              "panel-toggle"
              "launcher"
            ];
          };

          "Mod+Escape" = {
            _props.hotkey-overlay-title = "Lock Screen";
            spawn = [
              "noctalia"
              "msg"
              "lockScreen"
              "lock"
            ];
          };

          "Mod+V".spawn = [
            "noctalia"
            "msg"
            "panel-toggle"
            "clipboard"
          ];

          "XF86AudioRaiseVolume" = {
            _props.allow-when-locked = true;
            spawn = [
              "noctalia"
              "msg"
              "volume-up"
            ];
          };

          "XF86AudioLowerVolume" = {
            _props.allow-when-locked = true;
            spawn = [
              "noctalia"
              "msg"
              "volume-down"
            ];
          };

          "XF86AudioMute" = {
            _props.allow-when-locked = true;
            spawn = [
              "noctalia"
              "msg"
              "volume-mute"
            ];
          };

          "XF86MonBrightnessUp" = {
            _props.allow-when-locked = true;
            spawn = [
              "noctalia"
              "msg"
              "brightness-up"
            ];
          };

          "XF86MonBrightnessDown" = {
            _props.allow-when-locked = true;
            spawn = [
              "noctalia"
              "msg"
              "brightness-down"
            ];
          };

          "Mod+O".toggle-overview = { };

          "Mod+Q".close-window = { };

          "Mod+H".focus-column-left = { };
          "Mod+L".focus-column-right = { };
          "Mod+J".focus-window-down = { };
          "Mod+K".focus-window-up = { };

          "Mod+Shift+H".move-column-left = { };
          "Mod+Shift+L".move-column-right = { };
          "Mod+Shift+K".move-window-up = { };
          "Mod+Shift+J".move-window-down = { };

          "Mod+1".focus-workspace._args = [ 1 ];
          "Mod+2".focus-workspace._args = [ 2 ];
          "Mod+3".focus-workspace._args = [ 3 ];
          "Mod+4".focus-workspace._args = [ 4 ];
          "Mod+5".focus-workspace._args = [ 5 ];
          "Mod+6".focus-workspace._args = [ 6 ];
          "Mod+7".focus-workspace._args = [ 7 ];
          "Mod+8".focus-workspace._args = [ 8 ];
          "Mod+9".focus-workspace._args = [ 9 ];

          "Mod+Shift+1".move-column-to-workspace._args = [ 1 ];
          "Mod+Shift+2".move-column-to-workspace._args = [ 2 ];
          "Mod+Shift+3".move-column-to-workspace._args = [ 3 ];
          "Mod+Shift+4".move-column-to-workspace._args = [ 4 ];
          "Mod+Shift+5".move-column-to-workspace._args = [ 5 ];
          "Mod+Shift+6".move-column-to-workspace._args = [ 6 ];
          "Mod+Shift+7".move-column-to-workspace._args = [ 7 ];
          "Mod+Shift+8".move-column-to-workspace._args = [ 8 ];
          "Mod+Shift+9".move-column-to-workspace._args = [ 9 ];

          "Mod+R".switch-preset-column-width = { };
          "Mod+Shift+R".switch-preset-window-height = { };

          "Mod+F".maximize-column = { };
          "Mod+Shift+F".fullscreen-window = { };
          "Mod+Ctrl+F".expand-column-to-available-width = { };

          "Mod+C".center-column = { };
          "Mod+Ctrl+C".center-visible-columns = { };

          "Mod+Minus".set-column-width = {
            _args = [ "-10%" ];
          };

          "Mod+Equal".set-column-width = {
            _args = [ "+10%" ];
          };

          "Mod+Shift+Minus".set-window-height = {
            _args = [ "-10%" ];
          };

          "Mod+Shift+Equal".set-window-height = {
            _args = [ "+10%" ];
          };

          "Mod+Alt+V".toggle-window-floating = { };
          "Mod+Shift+V".switch-focus-between-floating-and-tiling = { };

          "Mod+W".toggle-column-tabbed-display = { };

          Print.screenshot = { };
          "Ctrl+Print".screenshot-screen = { };
          "Alt+Print".screenshot-window = { };

          "Mod+Shift+E".quit = { };
          "Mod+Shift+P".power-off-monitors = { };
        };
      };
    };
    home.packages = with pkgs; [
      nautilus
      gcr_4
    ];
  };
}
