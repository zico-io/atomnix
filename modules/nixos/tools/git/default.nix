{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.git;
  inherit (config.atomnix) user;
in {
  options.atomnix.tools.git = with types; {
    enable = mkBoolOpt false "Enable Git? No, really?";
    userName = mkOpt str user.fullName "git config user.name";
    userEmail = mkOpt str user.email "git config user.email";
  };

  config = mkIf cfg.enable {
    atomnix.system.home.extraOptions = {
      programs.lazygit = enabled;
      programs.git = {
        enable = true;
        package = pkgs.gitFull;
        inherit (cfg) userName userEmail;
        extraConfig = {
          init = {defaultBranch = "main";};
          pull = {rebase = true;};
          push = {autoSetupRemote = true;};
          credential.helper = "libsecret";
        };
      };
    };
  };
}
