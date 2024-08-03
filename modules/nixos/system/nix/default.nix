{ config, lib, pkgs, ... }:

with lib;
with lib.atomnix;

let cfg = config.atomnix.system.nix;

in {
  config = {
    nix.extraOptions = ''
      extra-substituters = https://devenv.cachix.org;
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=;    
    '';
  };
}
