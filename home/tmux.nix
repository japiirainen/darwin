{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
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

      # refresh status-bar every second
      set-option -s status-interval 1

      # Design tweaks
      setw -g clock-mode-colour colour1
      setw -g mode-style 'fg=colour1 bg=colour18 bold'
      set -g pane-border-style 'fg=colour1'
      set -g pane-active-border-style 'fg=colour3'
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'fg=colour1'
      set -g status-left ""
      set -g status-right '%Y-%m-%d %H:%M:%S'
      set -g status-right-length 50
      set -g status-left-length 10
      setw -g window-status-current-style 'fg=colour0 bg=colour1 bold'
      setw -g window-status-current-format ' #I #W #F '
      setw -g window-status-style 'fg=colour1 dim'
      setw -g window-status-format ' #I #[fg=colour7]#W #[fg=colour1]#F '
      setw -g window-status-bell-style 'fg=colour2 bg=colour1 bold'
      set -g message-style 'fg=colour2 bg=colour0 bold'
    '';
  };
}
