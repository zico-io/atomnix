{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
with lib;
with lib.atomnix;
{
  atomnix = {
    graphical.desktop = "hyprland";
    apps = {
      firefox = enabled;
      vscode = enabled;
    };
  };

  home = {
    packages = with pkgs; [
      figma-linux
      thunderbird
      vesktop
      tome4
    ];

    stateVersion = "23.11";
  };
}
