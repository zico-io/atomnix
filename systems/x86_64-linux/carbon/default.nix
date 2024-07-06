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
    ssh.startAgent = true;
    git = enabled;
    zsh = enabled;
    steam = enabled;
  };

  stylix = {
    enable = true;
    polarity = "dark";
    image = ./wp.png;
    homeManagerIntegration.autoImport = true;
    base16Scheme = "${inputs.tt-schemes}/base16/gruvbox-dark-pale.yaml";
    fonts = {
      monospace = {
        package = pkgs.sf-mono-liga;
        name = "Liga SFMono Nerd Font";
      };
    };
  };

  atomnix = {
    hardware = {
      network = enabled;
      laptop = enabled;
    };
    system = {
      locale = enabled;
      greetd = enabled;
    };
    graphical.desktop = "hyprland";
  };

  services = {
    autorandr = enabled;
    flatpak = enabled;
  };

  environment.systemPackages = [
    inputs.nixvim.packages.${system}.default
    pkgs.devenv
  ];

  system.stateVersion = "24.05";
}
