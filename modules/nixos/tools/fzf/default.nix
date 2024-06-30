{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.tools.fzf;
in {
  options.atomnix.tools.fzf = with types; {
    enable = mkBoolOpt false "Enable fzf?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [fzf];
    atomnix.system.home.extraOptions = {
      programs.fzf = {
        enable = true;

        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;

        defaultCommand = "${pkgs.fd} --type f --strip-cwd-prefix";
        defaultOptions = [
          "--border"
          "--prompt 'λ '"
          "--pointer ''"
          "--marker ''"
        ];
      };
    };
  };
}
