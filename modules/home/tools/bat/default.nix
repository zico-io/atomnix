{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix;
let
  cfg = config.atomnix.tools.bat;
  aliases = {
    bat = mkDefault "bat -p";
  };
in
{
  options.atomnix.tools.bat = with types; {
    enable = mkBoolOpt false "Enable bat?";
  };

  config = mkIf cfg.enable {
    programs = {
      bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          # batdiff
          batman
          batgrep
        ];
      };

      fish.shellAliases = aliases;
      bash.shellAliases = aliases;
      zsh.shellAliases = aliases;
    };
  };
}
