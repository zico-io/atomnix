{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.rofi;
in {
  options.atomnix.apps.rofi = with types; {
    enable = mkBoolOpt false "Enable rofi?";
  };

  config = mkIf cfg.enable {
    atomnix.system.home.extraOptions = {
      programs.rofi = {
        enable = true;

        plugins = with pkgs; [
          rofi-calc
          rofi-emoji
          rofi-pass
        ];

        extraConfig = {
          modi = "drun";
        };

        terminal = "wezterm";
        pass = {enable = true;};
      };
    };
  };
}
