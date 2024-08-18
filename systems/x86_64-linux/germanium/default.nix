{
  lib,
  system,
  inputs,
  pkgs,
  ...
}:
with lib;
with lib.atomnix;
{
  imports = [ ./hardware.nix ];

  programs = {
    ssh.startAgent = true;
    git = enabled;
    zsh = enabled;
  };

  atomnix = {
    system = {
      locale = enabled;
      stylix = enabled;
    };

    tools = {
      docker = enabled;
    };
  };

  wsl = {
    enable = true;
    defaultUser = "percules";
  };

  environment.systemPackages = with pkgs; [ devenv ];

  system.stateVersion = "24.05";
}
