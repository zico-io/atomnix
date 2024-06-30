{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.system.nix;
in {
  options.atomnix.system.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nixVersions.git "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    system.stateVersion = "23.11";

    environment.systemPackages = with pkgs; [
      nix-tree
      nix-index
      nixpkgs-fmt
      nil
    ];

    environment.variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };

    nix = let
      users = ["root" config.atomnix.user.name];
    in {
      inherit (cfg) package;

      settings = {
        cores = 4;
        experimental-features = ["nix-command" "flakes"];
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        sandbox = "relaxed";
        auto-optimise-store = true;
        trusted-users = users;
        allowed-users = users;
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };
  };
}
