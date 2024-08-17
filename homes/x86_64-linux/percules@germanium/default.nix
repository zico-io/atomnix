{ lib, config, ... }:
with lib;
with lib.atomnix;
{
  atomnix = {
    tools = {
      common = enabled;
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
