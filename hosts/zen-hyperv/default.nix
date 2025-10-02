{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../systems/hyperv
    ./hardware-configuration.nix
    ../../utils/vscode-server
    ../../utils/i3.nix
  ];

  networking = {
    hostName = "zen-hyperv";
  };

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
    ];
  };
}
