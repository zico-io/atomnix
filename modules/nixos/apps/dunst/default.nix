{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.dunst;
in {
  options.atomnix.apps.dunst = with types; {
    enable = mkBoolOpt false "Enable dunst?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [dunst];
  };
}
