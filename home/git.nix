{ pkgs, ... }:
let
  messageFile = ".config/git/message";
in
{
  home.packages = with pkgs; [ git-lfs ];

  programs = {
    git = {
      enable = true;
      userEmail = "joona.piirainen@gmail.com";

      userName = "japiirainen";

      ignores = [ ".DS_Store" ];

      lfs.enable = true;

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
        pushu = "! git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
        load = "! git fetch && git pull --rebase";
      };

      # Enhanced diffs
      delta = {
        enable = true;
        options = {
          light = false;
        };
      };

      extraConfig = {
        commit = {
          template = "~/${messageFile}";
        };

        merge = {
          conflictstyle = "zdiff3";
        };

        # Automaically push branch to remote
        push = {
          default = "current";
        };

        # reuse recovered resolution
        rerere = {
          enabled = true;
        };

        diff = {
          algorithm = "histogram";
        };
      };
    };

    gh.enable = true;

    gh.settings = {
      git_protocol = "ssh";
      aliases = {
        rcl = "repo clone";
      };
    };
  };


  home.file."${messageFile}".text = ''


# <type>: (If applied, this commit will...) <subject> (Max 50 char)
# |<----  Using a Maximum Of 50 Characters  ---->|

# Explain why this change is being made
# |<----   Try To Limit Each Line to a Maximum Of 72 Characters   ---->|

# Provide links or keys to any relevant tickets, articles or other resources
# Example: Github issue #23

# --- COMMIT END ---
# Type can be
#    feat     (new feature)
#    fix      (bug fix)
#    refactor (refactoring production code)
#    style    (formatting, missing semi colons, etc; no code change)
#    docs     (changes to documentation)
#    test     (adding or refactoring tests; no production code change)
#    chore    (updating grunt tasks etc; no production code change)
# --------------------
# Remember to
#    Capitalize the subject line
#    Use the imperative mood in the subject line
#    Do not end the subject line with a period
#    Separate subject from body with a blank line
#    Use the body to explain what and why vs. how
#    Can use multiple lines with "-" for bullet points in body
# --------------------

# Github Specifics

# Co-authored-by: name <name@example.com>
# Co-authored-by: another-name <github-username@users.noreply.github.com>
  '';
}
