{ lib, inputs, config, pkgs, ... }:

with lib;
with lib.atomnix;

let cfg = config.atomnix.system.stylix;

in {
  options.atomnix.system.stylix = with types; {
    enable = mkBoolOpt false "Enable stylix system themeing?";
  };

  config = mkIf cfg.enable {
  stylix = {
    enable = true;
    polarity = "dark";
    image = ./wp.png;
    base16Scheme = "${inputs.tt-schemes}/base16/gruvbox-dark-pale.yaml";
    fonts = {
      monospace = {
        package = pkgs.sf-mono-liga;
        name = "Liga SFMono Nerd Font";
      };
    };
  }; 
  };
}
