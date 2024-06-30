{
  config,
  inputs,
  system,
  lib,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.neovim;
in {
  options.atomnix.tools.neovim = with types; {
    enable = mkBoolOpt false "Enable neovim?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.nixvim.packages.${system}.default
    ];
    environment.variables = {
      EDITOR = "nvim";
    };
    atomnix.system.home.extraOptions = {
      home.sessionVariables = {
        EDITOR = "nvim";
      };
      programs = {
        zsh.shellAliases.vimdiff = "nvim -d";
        bash.shellAliases.vimdiff = "nvim -d";
        fish.shellAliases.vimdiff = "nvim -d";
      };
    };
  };
}
