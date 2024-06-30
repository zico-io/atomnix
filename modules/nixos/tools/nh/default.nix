{ config, lib, pkgs, ... }:

with lib;
with lib.atomnix;

let cfg = config.atomnix.tools.nh;
in {
  options.atomnix.tools.nh = with types; {
    enable = mkBoolOpt false "Enable nh?";
  };

  config = mkIf cfg.enable {
    nix.gc.automatic = mkForce false;
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${config.atomnix.user.name}/atomnix";
    };
  };
}
