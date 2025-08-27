{ config, pkgs, ... }:
{
  imports = [
    ../../systems/hyperv
    ./hardware-configuration.nix
    ../../utils/vscode-server
  ];

  networking = {
    hostName = "zen-hyperv";
  };

  services.openvpn.servers = {
    office = {
      config = ''config /home/easimer/.config/openvpn/office.ovpn'';
    };
  };
}
