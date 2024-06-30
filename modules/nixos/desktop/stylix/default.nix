{
  config,
  inputs,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.desktop.stylix;
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-pale;
in {
  options.atomnix.desktop.stylix = with types; {
    enable = mkBoolOpt false "Enable system-wide themeing with stylix?";
    polarity = mkOpt str "dark" "System polarity to use";
  };

  config = mkIf cfg.enable {
    stylix = {
        enable = true;
        inherit (cfg) polarity;
        image = ./wp.png;
        base16Scheme = colorScheme;
    };
    atomnix.system.home.extraOptions = {
      stylix = {
        enable = true;
        # inherit (cfg) polarity;
        # image = ./wp.png;
        # base16Scheme = colorScheme;
      };
    };
  };
}
