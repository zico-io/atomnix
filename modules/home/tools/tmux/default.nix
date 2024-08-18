{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.atomnix;

let
  cfg = config.atomnix.tools.tmux;

in
{
  options.atomnix.tools.tmux = with types; {
    enable = mkBoolOpt false "Enable terminal multiplexer?";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      tmuxinator = enabled;
      keyMode = "vi";
      shortcut = "Space";
      disableConfirmationPrompt = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
      ];
      extraConfig = "
set -g default-terminal \"tmux-256color\"
set -ga terminal-overrides \",xterm-256color:Tc\"
set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on
set-option -g allow-rename off

set-window-option -g mode-keys vi
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

bind '\"' split-window -v -c \"#{pane_current_path}\"
bind % split-window -h -c \"#{pane_current_path}\"
bind q kill-pane

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind-key -r -T prefix C-h resize-pane -L 5
bind-key -r -T prefix C-j resize-pane -D 5
bind-key -r -T prefix C-k resize-pane -U 5
bind-key -r -T prefix C-l resize-pane -R 5

bind r source-file ~/.config/tmux/tmux.conf

set -g status-position bottom
set -g status-justify left
set -g status-style 'fg=colour1 bg=colour0'
set -g status-left ''
set -g status-right '%Y-%m-%d %H:%M '
set -g status-right-length 50
set -g status-left-length 10

setw -g window-status-current-style 'fg=colour1 bg=colour0 bold'
setw -g window-status-current-format ' #I #W #F '

setw -g window-status-style 'fg=colour1 dim'
setw -g window-status-format ' #I #[fg=colour7]#W #[fg=colour1]#F '

setw -g window-status-bell-style 'fg=colour2 bg=colour1 bold'
      ";
    };
  };
}
