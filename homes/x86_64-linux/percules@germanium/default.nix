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
  home.stateVersion = "23.11";
}
