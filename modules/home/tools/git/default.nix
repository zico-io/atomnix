{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.git;
in {
  options.atomnix.tools.git = with types; {
    enable = mkBoolOpt false "Enable git multiplex?";
  };

  config = mkIf cfg.enable {
    programs = {
      lazygit = enabled;
      git = {
        enable = true;
        package = pkgs.gitFull;
        userName = "Nico Zamora";
        userEmail = "dev@zico.xyz";
        extraConfig = {
          init = {defaultBranch = "main";};
          url = {
            "ssh://git@github.com" = {
              insteadOf = "https://github.com";
            };
          };
        };
      };
    };
  };
}
