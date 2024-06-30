{
  config,
  pkgs,
  lib,
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
    fonts.packages = with pkgs; [
      noto-fonts
    ];
    atomnix.system.home.extraOptions = {
      programs.waybar = {
        enable = true;
        systemd.enable = true;

        settings = [
          {
            position = "top";
            layer = "top";
            height = 16;
            margin-top = 0;
            margin-bottom = 0;
            margin-left = 0;
            margin-right = 0;
            modules-left = ["hyprland/workspaces"];
            modules-center = ["cpu" "memory" "disk"];
            modules-right = ["tray" "network" "pulseaudio" "clock"];
            "clock" = {
              format = " {:%H:%M}";
              tooltip = "true";
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              format-alt = " {:%d/%m}";
            };

            "hyprland/workspaces" = {
              active-only = false;
              all-outputs = true;
              disable-scroll = false;
              on-scroll-up = "hyprctl dispatch workspace -1";
              on-scroll-down = "hyprctl dispatch workspace +1";
              format = "{icon}";
              on-click = "activate";
              format-icons = {
                urgent = "";
                active = "";
                default = "󰧞";
                sort-by-number = true;
              };
            };

            "battery" = {
              states = {
                good = 95;
                warning = 30;
                critical = 15;
              };
              format = "{icon}  {capacity}%";
              format-charging = "{capacity}% ";
              format-plugged = "{capacity}% ";
              format-alt = "{icon} {time}";
              format-icons = ["" "" "" "" ""];
            };

            "memory" = {
              format = "󰍛 {}%";
              format-alt = "󰍛 {used}/{total} GiB";
              interval = 5;
            };

            "cpu" = {
              format = "󰻠 {usage}%";
              format-alt = "󰻠 {avg_frequency} GHz";
              interval = 5;
            };

            "disk" = {
              format = "󰋊 {}%";
              format-alt = "󰋊 {used}/{total} GiB";
              interval = 5;
              path = "/mnt/Datos";
            };

            "network" = {
              format-wifi = "󰤨";
              format-ethernet = " {ifname}: Aesthetic";
              format-linked = " {ifname} (No IP)";
              format-disconnected = "󰤭";
              format-alt = " {ifname}: {ipaddr}/{cidr}";
              tooltip-format = "{essid}";
              on-click-right = "nm-connection-editor";
            };

            "tray" = {
              icon-size = 16;
              spacing = 5;
            };

            "backlight" = {
              format = "{icon} {percent}%";
              format-icons = ["" "" "" "" "" "" "" "" ""];
            };

            "pulseaudio" = {
              format = "{icon} {volume}%";
              format-muted = "󰝟";
              format-icons = {
                default = ["󰕿" "󰖀" "󰕾"];
              };
              on-click = "bash ~/.scripts/volume mute";
              on-scroll-up = "bash ~/.scripts/volume up";
              on-scroll-down = "bash ~/.scripts/volume down";
              scroll-step = 5;
              on-click-right = "pavucontrol";
            };
          }
        ];

        style = ''
                    * {
              border: none;
              border-radius: 0px;
              /*font-family: VictorMono, Iosevka Nerd Font, Noto Sans CJK;*/
              font-family: Liga SFMono Nerd Font, FontAwesome, Noto Sans CJK;
              font-size: 14px;
              font-style: normal;
              min-height: 0;
          }

          window#waybar {
              background: rgba(30, 30, 46, 0.5);
              border-bottom: 1px solid #282828;
              color: #f4d9e1
          }

          #workspaces {
          	background: #282828;
          	margin: 5px 5px 5px 5px;
            padding: 0px 5px 0px 5px;
          	border-radius: 16px;
            border: solid 0px #f4d9e1;
            font-weight: normal;
            font-style: normal;
          }
          #workspaces button {
              padding: 0px 5px;
              border-radius: 16px;
              color: #928374;
          }

          #workspaces button.active {
              color: #f4d9e1;
              background-color: transparent;
              border-radius: 16px;
          }

          #workspaces button:hover {
          	background-color: #E6B9C6;
          	color: black;
          	border-radius: 16px;
          }

          #custom-date, #clock, #battery, #pulseaudio, #network, #custom-randwall, #custom-launcher {
          	background: transparent;
          	padding: 5px 5px 5px 5px;
          	margin: 5px 5px 5px 5px;
            border-radius: 8px;
            border: solid 0px #f4d9e1;
          }

          #custom-date {
          	color: #D3869B;
          }

          #custom-power {
          	color: #24283b;
          	background-color: #db4b4b;
          	border-radius: 5px;
          	margin-right: 10px;
          	margin-top: 5px;
          	margin-bottom: 5px;
          	margin-left: 0px;
          	padding: 5px 10px;
          }

          #tray {
              background: #282828;
              margin: 5px 5px 5px 5px;
              border-radius: 16px;
              padding: 0px 5px;
              /*border-right: solid 1px #282738;*/
          }

          #clock {
              color: #E6B9C6;
              background-color: #282828;
              border-radius: 0px 0px 0px 24px;
              padding-left: 13px;
              padding-right: 15px;
              margin-right: 0px;
              margin-left: 10px;
              margin-top: 0px;
              margin-bottom: 0px;
              font-weight: bold;
              /*border-left: solid 1px #282738;*/
          }


          #battery {
              color: #9ece6a;
          }

          #battery.charging {
              color: #9ece6a;
          }

          #battery.warning:not(.charging) {
              background-color: #f7768e;
              color: #24283b;
              border-radius: 5px 5px 5px 5px;
          }

          #backlight {
              background-color: #24283b;
              color: #db4b4b;
              border-radius: 0px 0px 0px 0px;
              margin: 5px;
              margin-left: 0px;
              margin-right: 0px;
              padding: 0px 0px;
          }

          #network {
              color: #f4d9e1;
              border-radius: 8px;
              margin-right: 5px;
          }

          #pulseaudio {
              color: #f4d9e1;
              border-radius: 8px;
              margin-left: 0px;
          }

          #pulseaudio.muted {
              background: transparent;
              color: #928374;
              border-radius: 8px;
              margin-left: 0px;
          }

          #custom-randwall {
              color: #f4d9e1;
              border-radius: 8px;
              margin-right: 0px;
          }

          #custom-launcher {
              color: #e5809e;
              background-color: #282828;
              border-radius: 0px 24px 0px 0px;
              margin: 0px 0px 0px 0px;
              padding: 0 20px 0 13px;
              /*border-right: solid 1px #282738;*/
              font-size: 20px;
          }

          #custom-launcher button:hover {
              background-color: #FB4934;
              color: transparent;
              border-radius: 8px;
              margin-right: -5px;
              margin-left: 10px;
          }

          #custom-playerctl {
          	background: #282828;
          	padding-left: 15px;
            padding-right: 14px;
          	border-radius: 16px;
            /*border-left: solid 1px #282738;*/
            /*border-right: solid 1px #282738;*/
            margin-top: 5px;
            margin-bottom: 5px;
            margin-left: 0px;
            font-weight: normal;
            font-style: normal;
            font-size: 16px;
          }

          #custom-playerlabel {
              background: transparent;
              padding-left: 10px;
              padding-right: 15px;
              border-radius: 16px;
              /*border-left: solid 1px #282738;*/
              /*border-right: solid 1px #282738;*/
              margin-top: 5px;
              margin-bottom: 5px;
              font-weight: normal;
              font-style: normal;
          }

          #window {
              background: #282828;
              padding-left: 15px;
              padding-right: 15px;
              border-radius: 16px;
              /*border-left: solid 1px #282738;*/
              /*border-right: solid 1px #282738;*/
              margin-top: 5px;
              margin-bottom: 5px;
              font-weight: normal;
              font-style: normal;
          }

          #custom-wf-recorder {
              padding: 0 20px;
              color: #e5809e;
              background-color: #1E1E2E;
          }

          #cpu {
              background-color: #282828;
              /*color: #FABD2D;*/
              border-radius: 16px;
              margin: 5px;
              margin-left: 5px;
              margin-right: 5px;
              padding: 0px 10px 0px 10px;
              font-weight: bold;
          }

          #memory {
              background-color: #282828;
              /*color: #83A598;*/
              border-radius: 16px;
              margin: 5px;
              margin-left: 5px;
              margin-right: 5px;
              padding: 0px 10px 0px 10px;
              font-weight: bold;
          }

          #disk {
              background-color: #282828;
              /*color: #8EC07C;*/
              border-radius: 16px;
              margin: 5px;
              margin-left: 5px;
              margin-right: 5px;
              padding: 0px 10px 0px 10px;
              font-weight: bold;
          }

          #custom-hyprpicker {
              background-color: #282828;
              /*color: #8EC07C;*/
              border-radius: 16px;
              margin: 5px;
              margin-left: 5px;
              margin-right: 5px;
              padding: 0px 11px 0px 9px;
              font-weight: bold;
          }
        '';
      };
    };
  };
}
