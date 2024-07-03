{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.atomnix; let
  cfg = config.atomnix.apps.vscode;
in {
  options.atomnix.apps.vscode = with types; {
    enable = mkBoolOpt false "Enable Visual Studio Code?";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        jdinhlife.gruvbox
        vscodevim.vim
        yzhang.markdown-all-in-one
        github.copilot
        github.copilot-chat
        # dsznajder.es7-react-js-snippets
        # rvest.vs-code-prettier-eslint
        formulahendry.auto-rename-tag
        eamodio.gitlens
        wix.vscode-import-cost
      ];
      userSettings = {
        "editor.fontFamily" = "'Liga SFMono Nerd Font'";
        "editor.formatOnSave" = true;
        "editor.lineNumbers" = "relative";
        "editor.tabSize" = 2;
        "editor.detectIndentation" = false;
        "editor.quickSuggestions" = {
          "strings" = "on";
        };
        "terminal.integrated.fontFaimly" = "'Liga SFMono Nerd Font'";
        "workbench.colorTheme" = "Stylix";
        "github.copilot.editor.enableAutoCompletions" = true;
        "scss.lint.unknownAtRules" = "ignore";
        "[typescriptreact]" = {
          "editor.defaultFormatter" = "rvest.vs-code-prettier-eslint";
        };
        "explorer.confirmDragAndDrop" = false;
      };
    };
  };
}
