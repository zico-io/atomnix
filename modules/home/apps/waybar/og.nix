{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.waybar;
in {
  options.atomnix.apps.waybar = with types; {
    enable = mkBoolOpt false "Enable waybar?";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [pavucontrol];
    programs.waybar = {
      enable = true;
      systemd.enable = true;

      settings = [
        {
          layer = "top";
          height = 24;
          margin = "5 2 5 0";
          reload_style_on_change = true;
          modules-left = [
            "hyprland/workspaces"
            "hyprland/mode"
            "hyprland/scratchpad"
            # "custom/media"
          ];
          modules-center = ["hyprland/window"];
          modules-right = ["idle_inhibitor" "temperature" "cpu" "memory" "network" "pulseaudio" "backlight" "keyboard-state" "battery" "battery#bat2" "tray" "clock"];

          "keyboard-state" = {
            numlock = true;
            format = "{name} {icon}";
            format-icons = {
              "locked" = "";
              "unlocked" = "";
            };
          };

          "hyprland/mode" = {
            format = "<span style=\"italic\">{}</span>";
          };

          "hyprland/scratchpad" = {
            format = "{icon} {count}";
            show-empty = false;
            format-icons = ["" ""];
            tooltip = true;
            tooltip-format = "{app}: {title}";
          };

          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              "activated" = "";
              "deactivated" = "";
            };
          };

          "tray" = {
            spacing = 10;
          };

          "clock" = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format = "{:L%Y-%m-%d %I:%M}";
          };

          "cpu" = {
            format = " {usage}%";
          };

          "memory" = {
            format = " {}%";
          };

          "temperature" = {
            thermal-zone = 2;
            hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
            critical-threshold = 80;
            format-critical = "{icon} {temperatureC}°C";
            format = "{icon} {temperatureC}°C";
            format-icons = ["" "" ""];
          };

          "backlight" = {
            format = "{icon} {percent}%";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };

          "battery" = {
            states = {
              "warning" = 30;
              "critical" = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-icons = ["" "" "" "" ""];
          };

          "battery#bat2" = {
            bat = "BAT2";
          };

          "network" = {
            format-wifi = " ";
            format-ethernet = " {ifname}";
            tooltip-format = " {ifname} via {gwaddr}";
            format-linked = " {ifname} (No IP)";
            format-disconnected = "Disconnected ⚠ {ifname}";
            format-alt = " {ifname}: {ipaddr}/{cidr}";
          };

          "pulseaudio" = {
            scroll-step = 5;
            format = "{icon} {volume}%";
            format-bluetooth = " {icon} {volume}%";
            format-bluetooth-muted = "  {icon}";
            format-muted = "  ";
            # format-source = " {volume}%";
            # format-source-muted = "";
            format-icons = {
              default = ["" "" ""];
            };
            on-click = "pavucontrol";
            on-click-right = "foot -a pw-top pw-top";
          };
        }
      ];
      style = ''
                      * {
            border: none;
            font-size: 14px;
            font-family: "Liga SFMono Nerd Font" ;
            min-height: 25px;
            color: white;
        }

        window#waybar {
          background: transparent;
          margin: 5px;
         }

        #custom-logo {
          padding: 0 10px;
        }

        .modules-right {
          padding: 0 15px;
          border-radius: 15px;
          margin: 2px 5px;
          background: rgba(60, 56, 54, 0.8);
        }

        .modules-center {
          padding: 0 15px;
          border-radius: 15px;
          margin: 2px 0px;
          background: rgba(60, 56, 54, 0.8);
        }

        .modules-left {
          padding: 0 5px;
          border-radius: 15px;
          margin: 2px 5px;
          background: rgba(60, 56, 54, 0.8);
        }

        #battery,
        #custom-clipboard,
        #custom-colorpicker,
        #custom-powerDraw,
        #bluetooth,
        #pulseaudio,
        #network,
        #disk,
        #memory,
        #backlight,
        #cpu,
        #temperature,
        #custom-weather,
        #idle_inhibitor,
        #jack,
        #tray,
        #window,
        #workspaces,
        #clock {
          padding: 0 5px;
        }
        #pulseaudio {
          padding-top: 3px;
        }

        #temperature.critical,
        #pulseaudio.muted {
          color: #FF0000;
          padding-top: 0;
        }




        #clock{
          color: #5fd1fa;
        }

        #battery.charging {
            color: #ffffff;
            background-color: #26A65B;
        }

        #battery.warning:not(.charging) {
            background-color: #ffbe61;
            color: black;
        }

        #battery.critical:not(.charging) {
            background-color: #f53c3c;
            color: #ffffff;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }


        @keyframes blink {
            to {
                background-color: #ffffff;
                color: #000000;
            }
        }
      '';
    };
  };
}
