{
  config,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.direnv;
in {
  options.atomnix.tools.direnv = with types; {
    enable = mkBoolOpt false "Enable nix-direnv?";
  };

  config = mkIf cfg.enable {
    atomnix.system.home.extraOptions = {
      programs.direnv = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
