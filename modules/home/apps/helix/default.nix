{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.helix;
in {
  options.atomnix.apps.helix = with types; {
    enable = mkBoolOpt false "Enable helix?";
  };

  config = mkIf cfg.enable {
    programs.helix = enabled;
  };
}
