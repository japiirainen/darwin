{ ... }:
{
  programs.atuin = {
    enable = true;
    # TODO: this currently fails die to someone already creating ~/.config/atuin/
    # settings = {
    #   enter_accept = false;
    #   history_filter = [
    #     "^cd"
    #     "^ls"
    #     "^clear"
    #   ];
    # };
  };
}
