{ ... }:
{
  xdg.configFile."ghostty/config".text = ''
    # ghostty +show-config --default --docs | nvim

    # font-family = PragmataPro Mono Liga
    font-family = JetBrainsMono Nerd Font Mono
    font-size = 15

    # ghostty +list-theme
    # theme = iceberg-dark
    # theme = rose-pine
    theme = catppuccin-frappe

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
