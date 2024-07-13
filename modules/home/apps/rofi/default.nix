{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.rofi;
in {
  options.atomnix.apps.rofi = with types; {
    enable = mkBoolOpt false "Enable rofi-wayland?";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [gruvbox-plus-icons icomoon-feather];
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      terminal = "${pkgs.foot}/bin/foot";
    };
    xdg.configFile = {
      "rofi/config.rasi".enable = false;
      "rofi" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/percules/atomnix/modules/home/apps/rofi/config";
        recursive = true;
      };
    };
  };
}
