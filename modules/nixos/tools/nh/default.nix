{
  config,
  lib,
  ...
}:
with lib;
with lib.atomnix;

{
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${config.atomnix.user.name}/atomnix";
    };
}
