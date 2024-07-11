{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.graphical;
in {
  options.atomnix.graphical = with types; {
    desktop = mkOption {
      type = nullOr (enum ["hyprland"]);
      default = null;
    };
  };

  config = mkIf (cfg.desktop == "hyprland") {
    # home.packages = with pkgs; [wofi];

    atomnix = {
      apps = {
        waybar = enabled;
        foot = enabled;
        rofi = enabled;
      };

      tools = {
        zellij = enabled;
        dunst = enabled;
      };
    };

    programs.zsh.loginExtra = ''
      if [ -z "''${DISPLAY}" ] && [ $(tty) = "/dev/tty1" ]; then
        dbus-run-session Hyprland
      fi
    '';

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        exec-once = [
          "[workspace 2 silent] firefox"
        ];

        "monitor" = "eDP-1,1920x1080@60,0x0,1";

        env = [
          "XDG_SESSION_TYPE,wayland"
          "MOZ_ENABLE_WAYLAND,1"
          "WLR_NO_HARDWARE_CURSORS,1"
          "NIXOS_OZONE_WL,1"
        ];

        "windowrule" = "workspace 3, ^(vesktop)$";

        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
        };

        input = {
          kb_layout = "us";
          kb_options = "ctrl:nocaps";
          follow_mouse = 1;
          touchpad.natural_scroll = true;
          sensitivity = 0;
        };

        binds = {
          allow_workspace_cycles = true;
        };

        general = {
          border_size = 1;
          gaps_in = 2;
          gaps_out = 4;
          layout = "master";
        };

        decoration = {
          rounding = 4;
          fullscreen_opacity = 1;
          inactive_opacity = 0.9;
          active_opacity = 1;
          drop_shadow = false;
        };

        "$mod1" = "SUPER";

        bind = [
          "$mod1,1,workspace,1"
          "$mod1,2,workspace,2"
          "$mod1,3,workspace,3"
          "$mod1,4,workspace,4"
          "$mod1,5,workspace,5"
          "$mod1,6,workspace,6"
          "$mod1,7,workspace,7"
          "$mod1,8,workspace,8"
          "$mod1,9,workspace,9"

          "$mod1,Tab,workspace,previous"

          "$mod1 SHIFT,1,movetoworkspace,1"
          "$mod1 SHIFT,2,movetoworkspace,2"
          "$mod1 SHIFT,3,movetoworkspace,3"
          "$mod1 SHIFT,4,movetoworkspace,4"
          "$mod1 SHIFT,5,movetoworkspace,5"
          "$mod1 SHIFT,6,movetoworkspace,6"
          "$mod1 SHIFT,7,movetoworkspace,7"
          "$mod1 SHIFT,8,movetoworkspace,8"
          "$mod1 SHIFT,9,movetoworkspace,9"

          "$mod1,h,movefocus,l"
          "$mod1,j,movefocus,d"
          "$mod1,k,movefocus,u"
          "$mod1,l,movefocus,r"

          "$mod1 CTRL,h,movewindow,l"
          "$mod1 CTRL,j,movewindow,d"
          "$mod1 CTRL,k,movewindow,u"
          "$mod1 CTRL,l,movewindow,r"

          "$mod1 SHIFT,h,resizeactive,-10 0"
          "$mod1 SHIFT,j,resizeactive,0 10"
          "$mod1 SHIFT,k,resizeactive,0 -10"
          "$mod1 SHIFT,l,resizeactive,10 0"

          "$mod1,Q,killactive"
          "$mod1,h,togglefloating"
          "$mod1,r,togglesplit"

          "$mod1,f,fullscreen,1"
          "SUPER_SHIFT,F,fullscreen"

          "$mod1 SHIFT,r,exec,${pkgs.hyprland}/bin/hyprctl reload"

          "$mod1,Return,exec,foot"
          "$mod1 SHIFT,Return,exec,kitty"
          "$mod1,B,exec,firefox"
          "$mod1,space,exec,/home/percules/.config/rofi/scripts/launcher_t1"
        ];
      };
    };
  };
}
