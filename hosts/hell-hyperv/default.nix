{ config, pkgs, ... }:
{
  imports = [
    ../../systems/hyperv
    ./hardware-configuration.nix
    ../../utils/vscode-server
  ];

  networking.hostName = "hell-hyperv";

  services.openvpn.servers = {
    office = {
      config = ''config /home/easimer/.config/openvpn/office.ovpn'';
    };
  };

  users.users.easimer = {
    isNormalUser = true;
    description = "easimer";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      jetbrains.idea-community-bin
      alacritty
    ];
  };

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
      ];
    };
  };
  services.xrdp = {
    enable = true;
    defaultWindowManager = "${pkgs.i3}/bin/i3";
    openFirewall = true;
  };
}
