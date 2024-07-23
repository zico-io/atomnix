{
  lib,
  system,
  inputs,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; {
  imports = [
    ./hardware.nix
  ];

  programs = {
    ssh.startAgent = true;
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
    git = enabled;
    zsh = enabled;
  };

  atomnix.system = {
    locale = enabled;
    stylix = enabled;
  };

  wsl = {
    enable = true;
    defaultUser = "percules";
  };

  environment.systemPackages = [
    inputs.nixvim.packages.${system}.default
    pkgs.devenv
  ];

  system.stateVersion = "24.05";
}
