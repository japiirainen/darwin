{ config, lib, ... }:
let
  inherit (lib) mkIf;
  brewEnabled = config.homebrew.enable;
  emacsBrews = [
    "emacs-plus@30"
    "m4"
    "autoconf"
    "awk"
    "libpng"
    "freetype"
    "fontconfig"
    "gettext"
    "pcre2"
    "python-packaging"
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
    "capstone"
    "dtc"
    "fribidi"
    "jpeg-turbo"
    "lz4"
    "zstd"
    "libtiff"
    "gdk-pixbuf"
    "giflib"
    "gnu-sed"
    "gnu-tar"
    "libevent"
    "libunistring"
    "libidn2"
    "libnghttp2"
    "libtasn1"
    "nettle"
    "p11-kit"
    "unbound"
    "gnutls"
    "graphite2"
    "grep"
    "icu4c@75"
    "harfbuzz"
    "jansson"
    "pango"
    "librsvg"
    "libslirp"
    "libssh"
    "libusb"
    "little-cms2"
    "make"
    "ncurses"
    "pkg-config"
    "snappy"
    "vde"
    "qemu"
    "texinfo"
    "tree-sitter"
    "webp"
  ];
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

    casks = [
      "google-chrome"
      "firefox"
      "1password"
      "docker"
      "pgadmin4"
      "sage"
      "raycast"
      "slack"
    ];

    brews = emacsBrews ++ [
      # "skhd"
      "elan"
      "ghcup"
      "pulumi"
      "podman"
      "podman-compose"
      "sdl2"
      "pnpm"
      "portaudio"
      "cloudflared"
    ];
  };
}
