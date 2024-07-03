{
  lib,
  config,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.hardware.network;
in {
  options.atomnix.hardware.network = with types; {
    enable = mkBoolOpt false "Enable networking?";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    atomnix.user.extraGroups = ["networkmanager"];
  };
}
