{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.eww;
in {
  options.atomnix.apps.eww = with types; {
    enable = mkBoolOpt false "Enable widgets?";
  };

  config = mkIf cfg.enable {
    programs.eww = {
      enable = true;
      configDir = ./config;
    };
  };
}
