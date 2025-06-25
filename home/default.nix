{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ ];

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
    ];

    sessionVariables = {
      EDITOR = "hx";
    };
  };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.git = {
    enable = true;
    userName = "Daniel Meszaros";
    userEmail = "daniel.meszaros@r34dy.io";
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

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
