{
  lib,
  config,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix;
in {
  options.atomnix.graphical = with types; {
    desktop = mkOpt (nullOr (enum [])) null "Desktop environment to use.";
  };

  config = mkIf (cfg.graphical.desktop != null) {
    atomnix = {
      hardware.audio = enabled;
      system.fonts = enabled;
    };

    systemd.user.services = {
      pipewire.wantedBy = ["graphical-session.target"];
      pipewire-pulse.wantedBy = ["graphical-session.target"];
    };
  };
}
