{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.zellij;
in {
  options.atomnix.tools.zellij = with types; {
    enable = mkBoolOpt false "Enable zellij multiplex?";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;

      # enableBashIntegration = true;
      # enableFishIntegration = true;
      # enableZshIntegration = true;

      settings = {
        default_layout = "compact";
        on_force_close = "quit";
      };
    };
  };
}
