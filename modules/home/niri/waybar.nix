{ osConfig, lib, ... }:
let
  cfg = osConfig.programs.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = {
        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "idle_inhibitor"
          "battery"
          "wireplumber"
          "backlight"
          "network"
          "bluetooth"
          "power-profiles-daemon"
        ];
        clock = {
          interval = 1;
          format = "{:%F %a %T}";
          timezone = "Asia/Hong_Kong";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          max-length = 25;
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>U{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "tz_up";
            on-scroll-down = "tz_down";
          };
        };
        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "󰄰";
          };
          on-scroll-up = "niri msg action focus-workspace-up";
        };
        "niri/window" = {
          format-alt = "{app_id}";
          icon = true;
          separate-outputs = true;
          on-scroll-up = "niri msg action focus-column-left";
          on-scroll-down = "niri msg action focus-column-right";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰈈";
            deactivated = "󰈉";
          };
        };
        power-profiles-daemon = {
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
        battery = {
          format = "{icon}";
          format-icons = {
            default = [
              "󱊡"
              "󱊢"
              "󱊣"
            ];
            charging = [
              "󱊤"
              "󱊥"
              "󱊦"
            ];
          };
          tooltip-format = "{capacity}%";
        };
        backlight = {
          format = "{icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip-format = "{percent}%";
        };
      };
      style = ''
        * {
          border: none;
          border-radius: 10px;
          font-family: monospace;
          font-size: 13px;
          color: white;
        }

        window#waybar {
          border-radius: 0;
          background: rgba(25, 25, 25, 0.65);
        }

        window#waybar.empty #window {
          background: transparent;
        }

        .modules-left,
        .modules-center,
        .modules-right {
          margin: 5px 0;
        }

        #idle_inhibitor,
        #battery,
        #wireplumber,
        #backlight,
        #network,
        #bluetooth,
        #power-profiles-daemon {
          padding: 3px 10px;
          border-radius: 0;
          background: #1d1d1d;
        }

        #power-profiles-daemon {
          padding-left: 7px;
          padding: 3px 10px;
          margin-right: 5px;
          border-radius: 0 10px 10px 0;
          background: #1d1d1d;
        }

        #workspaces {
          padding: 0 5px;
          margin: 0 5px;
          background: #1d1d1d;
        }
        #workspaces button {
          padding: 3px;
        }
        #workspaces button:hover {
          background: none;
        }
      '';
    };
    systemd.user.services.waybar.wantedBy = [ "niri.service" ];
  };
}
