{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.aliases;

  # home = config.users.users.${config.atomnix.user.name}.home;

  aliases = {
    # Misc
    q = "exit";
    nnn = "nnn -C";
    nn = "nnn";
    dev = "tmuxp load";

    ll = "ls -l";
    la = "ls -la";
    cls = "clear && la";

    # nh
    rustdev = "nix develop -c nushell";

    # dust
    dust = "du -b";
  };
in {
  options.atomnix.tools.aliases = with types; {
    enable = mkBoolOpt false "Enable shell aliases?";
  };

  config = mkIf cfg.enable {
    atomnix.system.home.extraOptions = {
      programs = {
        bash.shellAliases = aliases;
        fish.shellAliases = aliases;
        zsh.shellAliases = aliases;
      };
    };
  };
}
