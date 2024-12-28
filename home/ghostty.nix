{ ... }:
{
  xdg.configFile."ghostty/config".text = ''
    # ghostty +show-config --default --docs | nvim

    font-family = PragmataPro Mono Liga
    font-size = 18

    # ghostty +list-theme
    theme = catppuccin-mocha

    mouse-hide-while-typing = true

    macos-titlebar-style = hidden
    macos-titlebar-proxy-icon = hidden
    macos-option-as-alt = true

    background-opacity = 0.90
    background-blur-radius = 40

    copy-on-select = clipboard
    shell-integration-features = cursor,sudo,no-title
  '';
}
