{
  config,
  lib,
  pkgs,
  system,
  inputs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.desktop.hyprland;
  script_startup = pkgs.writeShellScriptBin "start" ''
    $(pkgs.waybar)/bin/waybar &
    sleep 1
  '';
in {
  options.atomnix.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable Hyprland desktop environment?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [kitty wofi];
    programs = {
      zsh = enabled;
      hyprland = enabled;
    };

    xdg.portal = {
      # extraPortals = [inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland];
      # configPackages = [inputs.hyprland.packages.${system}.hyprland];
      xdgOpenUsePortal = true;
    };

    atomnix.system.home.extraOptions = {
      programs.zsh.loginExtra = ''
        if [ -z "''${DISPLAY}" ] && [ $(tty) = "/dev/tty1" ]; then
          dbus-run-session Hyprland
        fi
      '';

      wayland.windowManager.hyprland = {
        enable = true;
        # xwayland.enable = true;

        settings = {
          exec-once = [
            ''${script_startup}/bin/start''
          ];

          "monitor" = "eDP-1,1920x1080@60,0x0,1";

          env = [
            "XDG_SESSION_TYPE,wayland"
            "MOZ_ENABLE_WAYLAND,1"
            "WLR_NO_HARDWARE_CURSORS,1"
            "NIXOS_OZONE_WL,1"
          ];

          input = {
            kb_layout = "us";
            kb_options = "ctrl:nocaps";
            follow_mouse = 1;
            touchpad.natural_scroll = true;
            sensitivity = 0;
          };

          general = {
            border_size = 2;
            gaps_in = 4;
            gaps_out = 8;
            layout = "master";
          };

          decoration = {
            rounding = 8;
            fullscreen_opacity = 1;
            inactive_opacity = 0.9;
            active_opacity = 1;
            drop_shadow = false;
          };

          "$mod" = "SUPER";

          bind = [
            "$mod,k,movefocus,u"
            "$mod,j,movefocus,d"
            "$mod,h,movefocus,l"
            "$mod,l,movefocus,r"

            "$mod,Q,killactive"
            "$mod,h,togglefloating"
            "$mod,r,togglesplit"
            "$mod,f,fullscreen"

            "$mod SHIFT,r,exec,${pkgs.hyprland}/bin/hyprctl reload"

            "$mod,Return,exec,wezterm"
            "$mod SHIFT,Return,exec,kitty"
            "$mod,B,exec,firefox"
            "$mod,space,exec,${pkgs.wofi}/bin/wofi --show drun"
          ];
        };
      };
    };
  };
}
