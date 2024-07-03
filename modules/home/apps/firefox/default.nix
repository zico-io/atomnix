{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.firefox;
  defaultSettings = {
    "browser.aboutwelcome.enabled" = false;
    "browser.aboutConfig.showWarning" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
  };
in {
  options.atomnix.apps.firefox = with types; {
    enable = mkBoolOpt false "Enable Firefox?";
    extraConfig = mkOpt str "" "Extra configuration for the user profile JS file.";
    userChrome = mkOpt str "" "Extra configuration for the user chrome CSS file.";
    settings = mkOpt attrs defaultSettings "Settings to apply to the profile";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [firefox];
    programs.firefox = {
      enable = true;

      profiles.${config.snowfallorg.user.name} = {
        inherit (cfg) extraConfig userChrome settings;
        id = 0;
        inherit (config.snowfallorg.user) name;
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          react-devtools
          sponsorblock
          ublock-origin
          vimium
        ];
      };
    };
  };
}
