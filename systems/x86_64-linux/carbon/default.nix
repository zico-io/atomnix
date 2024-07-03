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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs = {
    git = enabled;
    zsh = enabled;
    steam = enabled;
  };

  atomnix.tools.batmon = enabled;

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

  atomnix = {
    hardware.network = enabled;
    system = {
      locale = enabled;
      greetd = enabled;
    };
    graphical.desktop = "hyprland";
  };

  services.flatpak.enable = true;

  environment.systemPackages = [
    inputs.nixvim.packages.${system}.default
    pkgs.devenv
  ];

  system.stateVersion = "24.05";
}
