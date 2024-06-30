{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.hardware.network;
  localhost = "127.0.0.1";
in {
  options.atomnix.hardware.network = with types; {
    enable = mkBoolOpt false "Enable Network Manager?";
    hosts =
      mkOpt attrs {}
      (mdDoc "An attribute set to merge with `networking.hosts`");
    dns = mkOpt (listOf str) [] "Custom DNS Server list";
  };

  config = mkIf cfg.enable {
    atomnix.user.extraGroups = ["networkmanager"];
    # environment.systemPackages = with pkgs; [
    #   networkmanager
    #   networkmanager-l2tp
    #   networkmanager-openvpn
    #   # networkmanager_strongswan
    #   networkmanagerapplet
    #   gnome.networkmanager-l2tp
    #   gnome.networkmanager-openvpn
    # ];

    services.openssh.enable = true;

    networking = {
      networkmanager = {
        enable = true;
        # hosts = {localhost = [localhost];} // cfg.hosts;
        insertNameservers = ["1.1.1.1" "8.8.8.8"] ++ (cfg.dns or []);
      };
      dhcpcd.wait = "background";
    };

    #   atomnix.system.home.extraOptions = {
    #     services.network-manager-applet.enable = true;
    #   };
    #
    #   systemd.services.NetworkManager-wait-online.enable = false;
  };
}
