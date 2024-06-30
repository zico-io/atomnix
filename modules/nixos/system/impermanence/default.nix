{
  config,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.system.disko;
in {
  options.atomnix.system.disko = with types; {
    enable = mkBoolOpt false "Enable disko configuration?";
    device = mkOpt str "/dev/sda" "Disk to target";
  };

  config = mkIf cfg.enable {
    disko.devices.disk.main.device = {inherit (cfg) device;};
    boot.initrd.postDeviceCommands = mkAfter ''
      zfs rollback -r zroot/local/root@blank
    '';
  };
}
