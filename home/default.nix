{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  home = {
    username = "easimer";
    homeDirectory = "/home/easimer";
    packages = with pkgs; [
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

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
