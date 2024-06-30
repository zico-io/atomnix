{
  config,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.zoxide;
  aliases = {
    cd = mkDefault "z";
    f = mkDefault "zi";
  };
in {
  options.atomnix.tools.zoxide = with types; {
    enable = mkBoolOpt false "Enable zoxide?";
  };

  config = mkIf cfg.enable {
    atomnix.system.home.extraOptions = {
      programs = {
        zoxide = {
          enable = true;
          enableZshIntegration = true;
        };
        fish.shellAliases = aliases;
        bash.shellAliases = aliases;
        zsh.shellAliases = aliases;
      };
    };
  };
}
