{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.zsh;
in {
  options.atomnix.tools.zsh = with types; {
    enable = mkBoolOpt false "Enable ZSH?";
    default = mkBoolOpt false "Set ZSH as default shell?";
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;

    atomnix.user.extraOptions = {
      shell = pkgs.zsh;
    };

    atomnix.system.home.extraOptions = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initExtra = ''
          export KEYTIMEOUT=1
          set -o vi
          source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

          eval $(oh-my-posh init zsh --config https://raw.githubusercontent.com/dreamsofautonomy/zen-omp/main/zen.toml)
        '';

        plugins = [];
      };
    };
  };
}
