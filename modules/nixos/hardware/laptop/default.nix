{
  config,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.hardware.laptop;
in {
  options.atomnix.hardware.laptop = with types; {
    enable = mkBoolOpt false "Enable laptop specific configurations?";
  };

  config = mkIf cfg.enable {
    atomnix.tools.batmon = enabled;

    powerManagement = {
      enable = true;
      powertop = enabled;
    };

    service = {
      thermald = enabled;
      logind = {
        extraConfig = "HandlePowerKey=suspend";
        lidSwitch = "suspend";
      };

      tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        };
      };
    };
  };
}
