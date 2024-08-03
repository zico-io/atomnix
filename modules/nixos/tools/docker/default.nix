{ lib, config, pkgs, ... }:

with lib;
with lib.atomnix;

let cfg = config.atomnix.tools.docker;
in {
  options.atomnix.tools.docker = with types; {
    enable = mkBoolOpt false "Enable Docker?";
  };

  config = mkIf cfg.enable {
    users.users.${config.atomnix.user.name}.extraGroups = [ "docker" ];

    environment.systemPackages = with pkgs; [ docker-compose ];
    
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
