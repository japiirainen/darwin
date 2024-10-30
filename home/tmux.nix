{ pkgs, ... }:
{
  programs.tmux = {
    # TODO: remove once unstable works again
    package = pkgs.pkgs-stable.tmux;

    enable = true;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];

    extraConfig = ''
      # Activity
      set -g mouse on
      set -g set-titles on
      set-option -g set-titles-string '#W: #T'
      setw -g monitor-activity on
      set -g visual-activity off

      # Tabs
      set -g base-index 1
      set -g renumber-windows on

      # Previous window/tab
      bind N previous-window

      # Clear history
      bind u send-keys C-l \; run-shell "sleep .3s" \; clear-history

      # Open new panes in current path
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
      bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
      bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
      bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
      bind -n 'C-\' if-shell "$is_vim" "send-keys 'C-\\'" "select-pane -l"

      bind-key -T copy-mode-vi C-h select-pane -L
      bind-key -T copy-mode-vi C-j select-pane -D
      bind-key -T copy-mode-vi C-k select-pane -U
      bind-key -T copy-mode-vi C-l select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l

      # vim-like pane resizing
      bind -r C-k resize-pane -U
      bind -r C-j resize-pane -D
      bind -r C-h resize-pane -L
      bind -r C-l resize-pane -R

      # Smart pane resizing with awareness of Vim splits.
      # See: https://github.com/melonmanchan/vim-tmux-resizer
      is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?x?)(diff)?$"'
      bind -n M-h if-shell "$is_vim" "send-keys M-h" "resize-pane -L 10"
      bind -n M-l if-shell "$is_vim" "send-keys M-l" "resize-pane -R 10"
      bind -n M-k if-shell "$is_vim" "send-keys M-k" "resize-pane -U 5"
      bind -n M-j if-shell "$is_vim" "send-keys M-j" "resize-pane -D 5"
      bind -n M-Left  if-shell "$is_vim" "send-keys M-h" "resize-pane -L 10"
      bind -n M-Right if-shell "$is_vim" "send-keys M-l" "resize-pane -R 10"
      bind -n M-Up    if-shell "$is_vim" "send-keys M-k" "resize-pane -U 5"
      bind -n M-Down  if-shell "$is_vim" "send-keys M-j" "resize-pane -D 5"

      # vim mode
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      # Bind escape to copy mode
      bind Escape copy-mode

      # p = paste
      unbind p
      bind p paste-buffer

      # loud or quiet?
      set-option -g visual-activity off
      set-option -g visual-bell off
      set-option -g visual-silence off
      set-window-option -g monitor-activity off
      set-option -g bell-action none

      # don't rename windows automatically
      set-option -g allow-rename off
    '';
  };
}
