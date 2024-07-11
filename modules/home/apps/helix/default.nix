{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.helix;
in {
  options.atomnix.apps.helix = with types; {
    enable = mkBoolOpt false "Enable helix?";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings = {
        editor = {
          line-number = "relative";
          auto-format = true;
          lsp.display-messages = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
      };
    };
  };
}
