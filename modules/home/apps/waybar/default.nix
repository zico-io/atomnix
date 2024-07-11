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
    stylix.targets.waybar.enable = false;
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
            "pulseaudio"
            "custom/seperator"
            "hyprland/workspaces"
            "custom/seperator"
            "cpu"
            "custom/seperator"
            "memory"
            "custom/seperator"
            "disk"
          ];
          modules-center = ["clock"];
          modules-right = [
            
            "backlight"
            "custom/seperator"
            "network"
            "custom/seperator"
            "battery"
            "custom/seperator"
            "custom/sysmenu"
          ];

          "custom/sysmenu" = {
            format = " 󰐥";
            on-click = "exec ~/.config/rofi/scripts/powermenu_t2";
          };

          # TODO: Find a better solution for module seperators
          "custom/seperator" = {
            # format = "";
            format = "|";
            tooltip = false;
          };

          "hyprland/workspaces" = {
            on-click = "activate";
            format = "{icon}";
            all-outputs = true;
            disable-scroll = true;
            format-icons = {
              # "1" = "";
              # "2" = "";
              # "3" = "";
              # "4" = "";
              # "5" = "";
              "default" = "󰍹";
              "active" = "";
              "urgent" = "";
              "empty" = "";
              "persistent" = "";
            };
            persistent-workspaces = {"*" = 5;};
          };

          "tray" = {
            spacing = 10;
          };

          "clock" = {
            tooltip-format = "<big>{:%d %B, %Y}</big>\n<tt><small>{calendar}</small></tt>";
            format = " {:L%H:%M}";
          };

          "cpu" = {
            format = "󰄧 {usage}%";
            min-length = 5;
          };

          "memory" = {
            format = " {used}GiB";
          };

          "disk" = {
            interval = 10;
            unit = "GB";
            format = " {free}";
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
            format-icons = [" " " " " " " " " "];
          };

          "network" = {
            format-wifi = "  {bandwidthDownBytes} - {bandwidthUpBytes}";
            format-ethernet = "  {bandwidthDownBytes} - {bandwidthUpBytes}";
            tooltip-format = "{ifname} via {essid}: {gwaddr}";
            format-linked = " {ifname} (No IP)";
            format-disconnected = "Disconnected ⚠ {ifname}";
            format-alt = " {ifname}: {ipaddr}/{cidr}";
          };

          "pulseaudio" = {
            scroll-step = 5;
            format = " {icon}";
            format-bluetooth = " {icon} {volume}%";
            format-bluetooth-muted = "  {icon}";
            format-muted = " 󰝟 ";
            # format-source = " {volume}%";
            # format-source-muted = "";
            format-icons = {
              default = [" " " " " "];
            };
            on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
            # on-click-right = "foot -a pw-top pw-top";
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
                            opacity: 0.98;
                        }

                        window#waybar {
                          background: transparent;
                          margin: 5px;
                         }

                        #custom-logo,
                        #custom-sysmenu,
                        #pulseaudio {
                          font-size: 18px;
                          padding: 0 5px;
                        }

                #custom-seperator {
                 padding: 1;
                 opacity: 0.33;
                }

                        .modules-right {
                          padding: 0 15px;
                          border-radius: 15px;
                          margin: 2px 5px;
                          background: rgba(60, 56, 54, 0.95);
                        }

                        .modules-center {
                          padding: 0 15px;
                          border-radius: 15px;
                          margin: 2px 0px;
                          background: rgba(60, 56, 54, 0.95);
                        }

                        .modules-left {
                          padding: 0 5px;
                          border-radius: 15px;
                          margin: 2px 5px;
                          background: rgba(60, 56, 54, 0.95);
                        }

                        #battery,
                        #custom-clipboard,
                        #custom-colorpicker,
                        #custom-powerDraw,
                        #bluetooth,
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
                        #clock {
                          padding: 0 5px;
                        }

        #workspaces {
          margin: 0;
        }

                        #temperature.critical {
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
