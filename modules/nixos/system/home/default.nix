{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.atomnix; {
  options.atomnix.system.home = with types; {
    file = mkOpt attrs {} (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile = mkOpt attrs {} (mdDoc "A set of files to be managed by home-manager's `xdg.configFile`.");
    extraOptions = mkOpt attrs {} "Options to pass directly to home-manager.";
  };

  config = {
    atomnix.system.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.atomnix.system.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.atomnix.system.home.configFile;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      backupFileExtension = "bak";
      users.${config.atomnix.user.name} =
        mkAliasDefinitions options.atomnix.system.home.extraOptions;
    };
  };
}
