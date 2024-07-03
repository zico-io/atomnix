{
  config,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.foot;
in {
  options.atomnix.apps.foot = with types; {
    enable = mkBoolOpt false "Enable foot?";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = mkForce "Liga SFMono Nerd Font:size=12";
          dpi-aware = mkForce "yes";
          pad = "8x4";
        };
      };
    };
  };
}
