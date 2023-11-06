{ config, lib, ... }:
let
  inherit (lib) mkIf;
  brewEnabled = config.homebrew.enable;
in
{
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-fish
  # For some reason if the Fish completions are added at the end of `fish_complete_path` they don't
  # seem to work, but they do work if added at the start.
  programs.fish.interactiveShellInit = mkIf brewEnabled ''
    if test -d (brew --prefix)"/share/fish/completions"
      set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
      set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
  '';
  homebrew = {

    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";
    global.brewfile = true;

    taps = [
      "koekeishiya/formulae"
      "d12frosted/emacs-plus"
    ];

    masApps = {
      Slack = 803453959;
    };

    casks = [
      "raycast"
      "google-chrome"
      "qutebrowser"
      "notion"
      "spotify"
      "miro"
      "zoom"
    ];

    brews = [
      "skhd"
      "elan"
      "emacs-plus@30"
      "m4"
      "autoconf"
      "awk"
      "ca-certificates"
      "libpng"
      "freetype"
      "fontconfig"
      "gettext"
      "pcre2"
      "glib"
      "xorgproto"
      "libxau"
      "libxdmcp"
      "libxcb"
      "libx11"
      "libxext"
      "libxrender"
      "lzo"
      "pixman"
      "cairo"
      "fribidi"
      "jpeg-turbo"
      "lz4"
      "xz"
      "zstd"
      "libtiff"
      "gdk-pixbuf"
      "giflib"
      "gnu-sed"
      "gnu-tar"
      "openssl@3"
      "libevent"
      "libunistring"
      "libidn2"
      "libtasn1"
      "nettle"
      "p11-kit"
      "unbound"
      "gnutls"
      "graphite2"
      "grep"
      "icu4c"
      "harfbuzz"
      "jansson"
      "pango"
      "librsvg"
      "little-cms2"
      "make"
      "pkg-config"
      "texinfo"
      "tree-sitter"
      "webp"
    ];
  };
}
