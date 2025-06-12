{
  inputs,
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  cfg = osConfig.programs.niri;
  inherit (inputs.niri-flake.lib.kdl)
    node
    plain
    leaf
    flag
    ;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri.config = [
      (plain "input" [
        (plain "keyboard" [ (plain "xkb" [ (leaf "layout" "us") ]) ])
        (plain "touchpad" [
          (flag "tap")
          (flag "natural-scroll")
        ])
      ])

      (node "output" "eDP-1" [
        (leaf "mode" "1920x1080@60.00")
        (leaf "scale" 1.25)
        (leaf "transform" "normal")
      ])

      (plain "layout" [
        (leaf "gaps" 8)
        (leaf "center-focused-column" "on-overflow")
        (plain "preset-column-widths" [
          (leaf "proportion" (1.0 / 3.0))
          (leaf "proportion" (1.0 / 2.0))
          (leaf "proportion" (2.0 / 3.0))
        ])
        (plain "default-column-width" [ (leaf "proportion" 0.5) ])
        (plain "focus-ring" [
          (leaf "width" 2)
          (leaf "active-color" "#7fc8ff")
          (leaf "inactive-color" "#505050")
        ])
        (plain "border" [ (flag "off") ])
      ])

      (leaf "screenshot-path" "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png")

      (plain "window-rule" [
        (leaf "match" {
          app-id = ''r#"firefox$"# title="^Picture-in-Picture$"'';
        })
        (leaf "open-floating" true)
      ])

      (plain "binds" [
        (plain "Mod+Shift+Slash" [ (flag "show-hotkey-overlay") ])
        (plain "Mod+Return" [
          (flag { hotkey-overlay-title = "Open Terminal"; })
          (leaf "spawn" [ "kitty" ])
        ])
        (plain "Mod+Space" [
          (flag { hotkey-overlay-title = "Open Launcher"; })
          (leaf "spawn" [ "fuzzel" ])
        ])
        (plain "Super+Escape" [
          (flag { hotkey-overlay-title = "Lock Screen"; })
          (leaf "spawn" [ "hyprlock" ])
        ])
        (plain "XF86AudioRaiseVolume" [
          (flag { allow-when-locked = true; })
          (leaf "spawn" [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "5%+"
          ])
        ])
        (plain "XF86AudioLowerVolume" [
          (flag { allow-when-locked = true; })
          (leaf "spawn" [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "5%-"
          ])
        ])
        (plain "XF86AudioMute" [
          (flag { allow-when-locked = true; })
          (leaf "spawn" [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ])
        ])
        (plain "XF86MonBrightnessUp" [
          (flag { allow-when-locked = true; })
          (leaf "spawn" [
            "${lib.getExe pkgs.brightnessctl}"
            "set"
            "5%+"
          ])
        ])
        (plain "XF86MonBrightnessDown" [
          (flag { allow-when-locked = true; })
          (leaf "spawn" [
            "${lib.getExe pkgs.brightnessctl}"
            "set"
            "5%-"
          ])
        ])
        (plain "Mod+Q" [ (flag "close-window") ])
        (plain "Mod+H" [ (flag "focus-column-left") ])
        (plain "Mod+J" [ (flag "focus-window-down") ])
        (plain "Mod+K" [ (flag "focus-window-up") ])
        (plain "Mod+L" [ (flag "focus-column-right") ])
        (plain "Mod+Ctrl+H" [ (flag "move-column-left") ])
        (plain "Mod+Ctrl+J" [ (flag "move-window-down") ])
        (plain "Mod+Ctrl+K" [ (flag "move-window-up") ])
        (plain "Mod+Ctrl+L" [ (flag "move-column-right") ])
        (plain "Mod+Home" [ (flag "focus-column-first") ])
        (plain "Mod+End" [ (flag "focus-column-last") ])
        (plain "Mod+Ctrl+Home" [ (flag "move-column-to-first") ])
        (plain "Mod+Ctrl+End" [ (flag "move-column-to-last") ])
        (plain "Mod+Shift+H" [ (flag "focus-monitor-left") ])
        (plain "Mod+Shift+J" [ (flag "focus-monitor-down") ])
        (plain "Mod+Shift+K" [ (flag "focus-monitor-up") ])
        (plain "Mod+Shift+L" [ (flag "focus-monitor-right") ])
        (plain "Mod+Shift+Ctrl+H" [ (flag "move-column-to-monitor-left") ])
        (plain "Mod+Shift+Ctrl+J" [ (flag "move-column-to-monitor-down") ])
        (plain "Mod+Shift+Ctrl+K" [ (flag "move-column-to-monitor-up") ])
        (plain "Mod+Shift+Ctrl+L" [ (flag "move-column-to-monitor-right") ])
        (plain "Mod+U" [ (flag "focus-workspace-down") ])
        (plain "Mod+D" [ (flag "focus-workspace-up") ])
        (plain "Mod+Ctrl+U" [ (flag "move-column-to-workspace-down") ])
        (plain "Mod+Ctrl+D" [ (flag "move-column-to-workspace-up") ])
        (plain "Mod+Shift+U" [ (flag "move-workspace-down") ])
        (plain "Mod+Shift+D" [ (flag "move-workspace-up") ])
        (plain "Mod+1" [ (leaf "focus-workspace" 1) ])
        (plain "Mod+2" [ (leaf "focus-workspace" 2) ])
        (plain "Mod+3" [ (leaf "focus-workspace" 3) ])
        (plain "Mod+4" [ (leaf "focus-workspace" 4) ])
        (plain "Mod+5" [ (leaf "focus-workspace" 5) ])
        (plain "Mod+6" [ (leaf "focus-workspace" 6) ])
        (plain "Mod+7" [ (leaf "focus-workspace" 7) ])
        (plain "Mod+8" [ (leaf "focus-workspace" 8) ])
        (plain "Mod+9" [ (leaf "focus-workspace" 9) ])
        (plain "Mod+Ctrl+1" [ (leaf "move-column-to-workspace" 1) ])
        (plain "Mod+Ctrl+2" [ (leaf "move-column-to-workspace" 2) ])
        (plain "Mod+Ctrl+3" [ (leaf "move-column-to-workspace" 3) ])
        (plain "Mod+Ctrl+4" [ (leaf "move-column-to-workspace" 4) ])
        (plain "Mod+Ctrl+5" [ (leaf "move-column-to-workspace" 5) ])
        (plain "Mod+Ctrl+6" [ (leaf "move-column-to-workspace" 6) ])
        (plain "Mod+Ctrl+7" [ (leaf "move-column-to-workspace" 7) ])
        (plain "Mod+Ctrl+8" [ (leaf "move-column-to-workspace" 8) ])
        (plain "Mod+Ctrl+9" [ (leaf "move-column-to-workspace" 9) ])
        (plain "Mod+R" [ (flag "switch-preset-column-width") ])
        (plain "Mod+F" [ (flag "maximize-column") ])
        (plain "Mod+Shift+F" [ (flag "fullscreen-window") ])
        (plain "Mod+C" [ (flag "center-column") ])
        (plain "Mod+Minus" [ (leaf "set-column-width" "-10%") ])
        (plain "Mod+Equal" [ (leaf "set-column-width" "+10%") ])
        (plain "Mod+Shift+Minus" [ (leaf "set-window-height" "-10%") ])
        (plain "Mod+Shift+Equal" [ (leaf "set-window-height" "+10%") ])
        (plain "Print" [ (flag "screenshot") ])
        (plain "Ctrl+Print" [ (flag "screenshot-screen") ])
        (plain "Alt+Print" [ (flag "screenshot-window") ])
        (plain "Mod+Shift+E" [ (flag "quit") ])
        (plain "Mod+Shift+P" [ (flag "power-off-monitors") ])
      ])
    ];
  };
}
