{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.common;
in {
  options.atomnix.tools.common = with types; {
    enable = mkBoolOpt false "Enable common tools?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ### File management
      unzip
      trashy

      ### Shell utils
      killall
      jq
      fd
      rsync
      curl
      wget
      just
      xclip
      imagemagick
      ffmpeg-full

      ### Shell apps
      du-dust
      btop

      ### Hardware utils
      usbutils
      pciutils
      smartmontools
      wirelesstools
    ];
  };
}
