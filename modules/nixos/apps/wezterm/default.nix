{
  config,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.wezterm;
in {
  options.atomnix.apps.wezterm = with types; {
    enable = mkBoolOpt false "Enable WezTerm?";
  };

  config = mkIf cfg.enable {
    atomnix.system.home.extraOptions = {config, ...}: {
      stylix.targets.wezterm.enable = false;
      programs.wezterm = enabled;

      xdg.configFile = {
        "wezterm/wezterm.lua".enable = false;
        "wezterm" = {
          source = config.lib.file.mkOutOfStoreSymlink "/home/percules/atomnix/modules/nixos/apps/wezterm";
          recursive = true;
        };
      };
    };
  };
}
