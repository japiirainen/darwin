{ ... }:
{
  xdg.configFile."ghostty/config".text = ''
    # ghostty +show-config --default --docs | nvim

    font-family = CommitMono Nerd Font Mono
    font-size = 15

    # ghostty +list-theme
    # theme = rose-pine
    # theme = catppuccin-frappe
    theme = iceberg-dark

    mouse-hide-while-typing = true

    macos-titlebar-style = hidden
    macos-titlebar-proxy-icon = hidden
    macos-option-as-alt = true

    # enable transparency
    background-opacity = 0.90
    background-blur-radius = 40

    copy-on-select = clipboard
    shell-integration-features = cursor,sudo,no-title
  '';
}
