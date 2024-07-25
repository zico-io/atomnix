{ config, lib, pkgs, ... }:

with lib;
with lib.atomnix;

let cfg = config.atomnix.tools.dev;

in {
  options.atomnix.tools.dev = with types; {
    enable = mkBoolOpt false "Enable developer tools?";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ### Python
      pipx

      ### JavaScript
      nodejs_22
      corepack_22
      
      ### Terraform
      cosign
      tenv
    ];
  };
}
