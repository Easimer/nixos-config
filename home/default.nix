{
  inputs,
  lib,
  config,
  pkgs,
  fetchFromGitHub,
  ...
}:
{
  imports = [ ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  home = {
    username = "easimer";
    homeDirectory = "/home/easimer";
    packages = with pkgs; [
      nil
      nixfmt-rfc-style
      helix
      unzip
      less
      nmap
      fzf
      file
      which
      tree
      gnutar
      pinentry
      rbw
      tmux
      gitui
      nginx
      mkcert
      jujutsu
      inputs.pomodoro.packages.${system}.app
      #lombok
      docker
      #kubectl
      #kubetui
    ];

    sessionVariables = {
      EDITOR = "hx";
      COLORTERM = "truecolor";
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };

    file = {
      "${config.home.homeDirectory}/.tmux.conf" = {
        source = ./tmux.conf;
      };
      "${config.home.homeDirectory}/.config/i3/config" = {
        source = ./i3/config;
      };
      "${config.home.homeDirectory}/.gdbinit" = {
        source = ./gdbinit;
      };
    };
  };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      garbage = "nix-collect-garbage --delete-older-than 14d";
      ga = "git add";
      gc = "git commit";
      gs = "git status";
      gdiff = "git diff";
      gp = "git push";
      gco = "git checkout";
      gamen = "git commit --amen";
      gg = "git grep";
      jjpb = "jj git push --allow-new -b";
      jjbs = "jj bookmark set";
      jjn = "jj new";
      jjd = "jj describe";
      jjs = "jj show";
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Daniel Meszaros";
    userEmail = "daniel.meszaros@r34dy.io";
    extraConfig = {
      credential.helper = "store";
      column.ui = "auto";
      diff = {
        algorithm = "histogram";
        colorMoved = "default";
        colorMovedWs = "allow-indentation-change";
        mnemonicPrefix = "true";
        renames = "true";
      };
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "ferra";
      editor = {
        line-number = "absolute";
        rulers = [ 80 ];
        auto-pairs = false;
        end-of-line-diagnostics = "warning";
        inline-diagnostics = {
          cursor-line = "error";
          other-lines = "error";
        };
        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "separator"
            "version-control"
          ];
        };
        lsp = {
          display-inlay-hints = true;
        };
        # backup = {
        #   kind = "auto";
        #   directories = [ "/tmp/" ];
        # };
      };
    };
    languages = {
      language-server.clangd = {
        command = "clangd";
        args = [ "--compile-commands-dir=./out" ];
      };

      #language-server.jdtls =
      #  let
      #    lombok = "${pkgs.lombok}/share/java/lombok.jar";
      #  in
      #  {
      #    command = "jdtls";
      #    args = [
      #      "--jvm-arg=-javaagent:${lombok}"
      #      "--jvm-arg=-Xbootclasspath/a:${lombok}"
      #    ];
      #  };

      language-server.basedpyright = {
        command = "basedpyright-langserver";
        args = [ "--stdio" ];
        config = { };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
        {
          name = "cpp";
          auto-format = false;
        }
        {
          name = "python";
          language-servers = [
            "basedpyright"
            "ruff"
          ];
        }
      ];
    };
  };

  programs.rbw = {
    enable = true;

    settings = {
      email = "easimer@gmail.com";
      base_url = "https://vault.easimer.net";
      identity_url = "https://vault.easimer.net/identity";
      pinentry = pkgs.pinentry;
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
