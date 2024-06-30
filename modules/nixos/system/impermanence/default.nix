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

    programs.fuse.userAllowOther = true;
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = ["/etc/machine-id"];
    };

    atomnix.system.home.extraOptions = {
      home.persistence."/persist/home" = {
        allowOther = true;
        directories = [
          ".gnupg"
          ".ssh"
          ".nixops"
          ".local/share/keyrings"
          ".local/share/direnv"
          "atomnix"
          "git"
        ];
      };
    };
  };
}
