{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.yazi;
in {
  options.atomnix.tools.yazi = with types; {
    enable = mkBoolOpt false "Enable yazi?";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ffmpegthumbnailer
      unar
      jq
      poppler
      fd
      ripgrep
      fzf
    ];

    programs.yazi = {
      enable = true;

      enableNushellIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;

      settings = {};
      keymap = {};
    };
  };
}
