_: {
  programs.git.enable = true;

  programs.git = {
    userEmail = "joona.piirainen@gmail.com";

    userName = "japiirainen";

    ignores = [ ".DS_Store" ];

    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      pl = "pull";
      ps = "push";
      pf = "push --force-with-lease";
      aa = "add -A";
      upd = "! git pull && git submodule update --recursive";
    };
    # Enhanced diffs
    delta.enable = true;
  };

  programs.gh.enable = true;

  programs.gh.settings = {
    git_protocol = "ssh";
    aliases = {
      rcl = "repo clone";
    };
  };
}
