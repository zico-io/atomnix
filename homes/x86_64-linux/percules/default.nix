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
    tools = {
      common = enabled;
      dev = enabled;
    };
    apps.helix = enabled;
  };

  home.sessionVariables = {EDITOR = "hx";};
}
