{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.system.systemd-boot;
in {
  options.atomnix.system.systemd-boot = with types; {
    enable = mkBoolOpt false "Enable systemd boot?";
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
          editor = false;
        };
        efi.canTouchEfiVariables = true;
      };
      initrd.availableKernelModules = ["thinkpad_acpi"];
      # kernelPackages = pkgs.linuxPackages_zen;
    };
  };
}
