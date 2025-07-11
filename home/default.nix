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

  nixpkgs.overlays = [
    inputs.helix-editor.overlays.default
  ];

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
    ];

    sessionVariables = {
      EDITOR = "hx";
      COLORTERM = "truecolor";
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gs = "git status";
      gdiff = "git diff";
      gp = "git push";
      gco = "git checkout";
      gamen = "git commit --amen";
      gg = "git grep";
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
      branch.sort = "-commiterdate";
      column.ui = "auto";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
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
        end-of-line-diagnostics = "warning";
        inline-diagnostics = {
          cursor-line = "error";
          other-lines = "error";
        };
        backup = {
          kind = "auto";
          directories = [ "/tmp/" ];
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      }
    ];
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
