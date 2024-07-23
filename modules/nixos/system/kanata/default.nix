{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.system.kanata;
in {
  options.atomnix.system.kanata = with types; {
    enable = mkBoolOpt false "Enable kanata remapping?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ kanata ];
    users.users.${config.atomnix.user.name}.extraGroups = [ "uinput" ];

    services.kanata = {
      enable = true;
      keyboards.internalKeyboard = {
        devices = [];
        extraDefCfg = "process-unmapped-keys yes";
        config = '' 
          (defsrc
            caps
          )
          (defvar
            tap-time 150
            hold-time 200
          )
          (defalias
            caps (tap-hold 100 100 esc lctl)
          )

          (deflayer base
            @caps
          )
        '';
      };
    };
  };
  }

