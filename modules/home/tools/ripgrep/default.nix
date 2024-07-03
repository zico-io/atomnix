{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.ripgrep;
  aliases = {
    grep = mkDefault "rg --color=auto";
    egrep = mkDefault "rg -e --color=auto";
    fgrep = mkDefault "rg -f --color=auto";
  };
in {
  options.atomnix.tools.ripgrep = with types; {
    enable = mkBoolOpt false "Enable ripgrep?";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ripgrep];
    programs = {
      fish.shellAliases = aliases;
      bash.shellAliases = aliases;
      zsh.shellAliases = aliases;
    };
  };
}
