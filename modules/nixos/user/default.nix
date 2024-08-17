{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.atomnix;
let
  cfg = config.atomnix.user;
in
{
  options.atomnix.user = with types; {
    name = mkOpt str "percules" "The name to use for the user account.";
    fullName = mkOpt str "Nico Zamora" "The full name of the user.";
    email = mkOpt str "dev@zico.xyz" "The email of the user.";
    initialPassword = mkOpt str "password" "The initial password of user account.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } (mdDoc "Extra options passed to `users.users.<name>`.");
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";
      shell = pkgs.zsh;

      # Arbitrary user ID to use for the user. Since I only
      # have a single user on my machines this won't ever collide.
      # However, if you add multiple users you'll need to change this
      # so each user has their own unique uid (or leave it out for the
      # system to select).
      uid = 1000;

      extraGroups = [ "wheel" ] ++ cfg.extraGroups;
    } // cfg.extraOptions;
  };
}
