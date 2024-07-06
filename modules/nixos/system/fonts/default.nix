{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.system.fonts;
in {
  options.atomnix.system.fonts = with types; {
    enable = mkBoolOpt false "Enable system-wide fonts?";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [font-manager];

    fonts = {
      packages = with pkgs;
        [
          corefonts # MS Windows fonts
          noto-fonts
          noto-fonts-emoji
          cantarell-fonts # GNOME 3 default font
          font-awesome
          sf-mono-liga
          # apple-fonts.sf-pro-nerd
          # apple-fonts.sf-mono-nerd
          # apple-fonts.sf-compact-nerd
          (nerdfonts.override {
            fonts = [
              "CascadiaCode" # Windows Terminal default font
              "FiraCode" # Best ligature-featured font
              "JetBrainsMono" # Daily-driver for development
              "NerdFontsSymbolsOnly"
            ];
          })
        ]
        ++ cfg.fonts;

      fontconfig = {
        enable = true;
        antialias = true;
        hinting = {
          enable = true;
          autohint = true;
        };
        defaultFonts = {
          emoji = ["Segoe UI Emoji" "Noto Fonts Emoji"];
        };
      };
    };
  };
}
