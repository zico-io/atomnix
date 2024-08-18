{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix;
{
  config = {
    atomnix.tools = {
      aliases = enabled;
      bat = enabled;
      direnv = enabled;
      eza = enabled;
      fzf = enabled;
      git = enabled;
      ripgrep = enabled;
      yazi = enabled;
      zoxide = enabled;
      zsh = enabled;
    };

    programs = {
      atuin = enabled;
      navi = enabled;
    };

    home.packages = with pkgs; [
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
