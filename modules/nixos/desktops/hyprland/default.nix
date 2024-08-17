{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix;
let
  cfg = config.atomnix.graphical;
in
{
  options.atomnix.graphical = with types; {
    desktop = mkOption { type = nullOr (enum [ "hyprland" ]); };
  };

  config = mkIf (cfg.desktop == "hyprland") {
    environment.systemPackages = with pkgs; [ kitty ];
    programs.hyprland = enabled;

    xdg.portal.xdgOpenUsePortal = true;
  };
}
