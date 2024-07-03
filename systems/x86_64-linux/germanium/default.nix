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
    git = enabled;
    zsh = enabled;
  };

  atomnix.system.locale = enabled;

  wsl = {
    enable = true;
    defaultUser = "percules";
  };

  stylix = {
    enable = true;
    polarity = "dark";
    image = ./wp.png;
    base16Scheme = "${inputs.tt-schemes}/base16/gruvbox-dark-pale.yaml";
    fonts = {
      monospace = {
        package = pkgs.sf-mono-liga;
        name = "Liga SFMono Nerd Font";
      };
    };
  };

  environment.systemPackages = [
    inputs.nixvim.packages.${system}.default
    pkgs.devenv
  ];

  system.stateVersion = "24.05";
}
