{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
with lib;
with lib.atomnix; let
  name = config.atomnix.user.name;
  home = config.atomnix.user.home.directory;
in {
  atomnix = {
    graphical.desktop = "hyprland";
    apps = {
      firefox = enabled;
      vscode = enabled;
    };
  };

  home = {
    programs = {
      thunderbird = enabled;
      figma-linux = enabled;
    };

    packages = with pkgs; [
      vesktop
      tome4
    ];

    stateVersion = "23.11";
  };
}
