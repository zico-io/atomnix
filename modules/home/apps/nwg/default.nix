{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.nwg;
in {
  options.atomnix.apps.nwg = with types; {
    enable = mkBoolOpt false "Enable nwg-shell suite?";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nwg-panel
    ];
  };
}
