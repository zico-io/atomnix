{ config, lib, pkgs, ... }:

with lib;
with lib.atomnix;

let cfg = config.atomnix.tools.tmux;

in {
  options.atomnix.tools.tmux = with types; {
    enable = mkBoolOpt false "Enable terminal multiplexer?";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
    };
  };
}
