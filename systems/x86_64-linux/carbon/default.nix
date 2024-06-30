{
  lib,
  inputs,
  ...
}:
with lib;
with lib.atomnix; {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
    ./hardware.nix
  ];

  atomnix = {
    system.systemd-boot = enabled;
    suites.common = enabled;
    hardware = {
      audio = enabled;
      network = enabled;
    };
    apps = {
      dunst = enabled;
      firefox = enabled;
      rofi = enabled;
      wezterm = enabled;
      waybar = enabled;
    };
    desktop = {
      stylix = enabled;
      hyprland = enabled;
    };
  };
}
