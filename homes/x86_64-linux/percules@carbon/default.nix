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
    tools = {
      dev = enabled;
      tmux = enabled;
    };
    apps = {
      firefox = enabled;
      helix = enabled;
    };
  };

  home = {
    packages = with pkgs; [
      figma-linux
      thunderbird
      vesktop
      tome4
    ];

    sessionVariables = {
      EDITOR = "hx";
    };

    stateVersion = "23.11";
  };
}
