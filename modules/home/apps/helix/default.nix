{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.helix;
  helixPkgs = with pkgs; [
    nixd
    rust-analyzer
    nodePackages.bash-language-server
    nodePackages.yaml-language-server
    nodePackages.typescript-language-server
  ];
  helixWrapped = pkgs.writeShellScriptBin "hx" ''
    PATH="${lib.makeBinPath helixPkgs}:$PATH"
    ${pkgs.helix}/bin/hx "$@"
  '';
in {
  options.atomnix.apps.helix = with types; {
    enable = mkBoolOpt false "Enable helix?";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [nodePackages.typescript-language-server];
    programs.helix = {
      enable = true;
<<<<<<< HEAD
      package = helixWrapped;
      
      settings.editor = {
        auto-format = true;
        line-number = "relative";
        lsp.display-messages = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
=======
      languages = [
        {
          name = "typescript";
          auto-format = true;
        }
      ];
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
>>>>>>> 6a75d4f (Add typescript lsp)
        };
      };
      languages = {
        language-server = {
          nixd = { command = "nixd"; };
        };
        language = [
        {
          name = "typescript";
          auto-format = true;
          formatter = { command = "prettier"; args = ["--parser" "typescript"]; };
        }
        {
          name = "tsx";
          auto-format = true;
          formatter = { command = "prettier"; args = ["--parser" "typescript"]; };
        }
        {
          name = "jsx";
          auto-format = true;
          formatter = { command = "prettier"; args = ["--parser" "typescript"]; };
        }
        {
          name = "nix";
          language-servers = [ "nixd" ];
          auto-format = true;
        }
        ];
      };
   };
  };
}
