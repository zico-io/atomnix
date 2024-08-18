{ lib, config, ... }:
with lib;
with lib.atomnix;
{
  atomnix = {
    tools = {
      dev = enabled;
      tmux = enabled;
    };
    apps.helix = enabled;
  };

  home = {
    sessionVariables = {
      EDITOR = "hx";
    };
    stateVersion = "23.11";
  };
}
