{
  lib,
  config,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.graphical;
in {
  options.atomnix.graphical = with types; {
    desktop = mkOption {
      type = nullOr (enum ["pantheon"]);
    };
  };

  config = mkIf (cfg.desktop == "pantheon") {
    # Enable the X11 windowing system.
    services = {
      xserver = {
        enable = true;

        # Enable the Pantheon Desktop Environment.
        displayManager.lightdm.enable = true;
        desktopManager.pantheon.enable = true;

        # Configure keymap in X11
        xkb = {
          layout = "us";
          options = "ctrl:swapcaps";
        };
        # Enable automatic login for the user.
        displayManager.autoLogin = {
          enable = true;
          user = "percules";
        };
      };
    };
  };
}
