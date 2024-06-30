{
  config,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.suites.common;
in {
  options.atomnix.suites.common = with types; {
    enable = mkBoolOpt false "Enable common configuration?";
  };

  config = mkIf cfg.enable {
    atomnix = {
      system = {
        fonts = enabled;
        locale = enabled;
        nix = enabled;
      };
      tools = {
        common = enabled;
        aliases = enabled;
        bat = enabled;
        direnv = enabled;
        eza = enabled;
        fzf = enabled;
        git = enabled;
        neovim = enabled;
        nh = enabled;
        ripgrep = enabled;
        yazi = enabled;
        zoxide = enabled;

        ### Shell
        ohmyposh = enabled;
        zsh = {
          enable = true;
          default = true;
        };
      };
    };
  };
}
