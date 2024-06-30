{
  config,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.ohmyposh;
in {
  options.atomnix.tools.ohmyposh = with types; {
    enable = mkBoolOpt false "Enable oh-my-posh prompt?";
  };

  config = mkIf cfg.enable {
    atomnix.system.home.extraOptions = {
      programs.oh-my-posh = {
        enable = true;
      };
    };
  };
}
