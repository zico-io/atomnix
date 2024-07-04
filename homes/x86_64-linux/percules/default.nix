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
    tools.common = enabled;
  };

  home.sessionVariables = {EDITOR = "nvim";};
}
