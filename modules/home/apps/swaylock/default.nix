{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.swaylock;
in {
  options.atomnix.apps.swaylock = with types; {
    enable = mkBoolOpt false "Enable swaylock?";
  };

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = false;

      settings = {
        daemonize = true;
        show-failed-attempts = true;
        clock = true;
        screenshot = true;
        effect-blur = "15x15";
        effect-vignette = "1:1";
        font = "Liga SFMono Nerd Font";
        indicator = true;
        indicator-radius = 100;
        indicator-thickness = 20;
        # line-color = "ebdbb2";
        # ring-color = "1d2021";
        # inside-color = "3c3836";
        # key-hl-color = "eb6f92";
        # separator-color = "ebdbb2";
        # text-color = "ebdbb2";
        text-caps-lock-color = "";
        # line-ver-color = "98971a";
        # ring-ver-color = "98971a";
        # inside-ver-color = "3c3836";
        # text-ver-color = "ebdbb2";
        # ring-wrong-color = "cc241d";
        # text-wrong-color = "cc241d";
        # inside-wrong-color = "3c3836";
        # inside-clear-color = "3c3836";
        # text-clear-color = "e0def4";
        # ring-clear-color = "9ccfd8";
        # line-clear-color = "cc241d";
        # line-wrong-color = "cc241d";
        # bs-hl-color = "31748f";
        grace = 0;
        grace-no-mouse = true;
        grace-no-touch = true;
        datestr = "%a, %B %e";
        timestr = "%I:%M %p";
        fade-in = 0.1;
        ignore-empty-password = true;
      };
    };
  };
}
