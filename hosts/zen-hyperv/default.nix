{ config, pkgs, ... }:
{
  imports = [
    ../../systems/hyperv
    ./hardware-configuration.nix
    ../../utils/vscode-server
  ];

  networking = {
    hostName = "zen-hyperv";
    interfaces = {
      eth0.ipv4.addresses = [
        {
          address = "172.28.48.44";
          prefixLength = 20;
        }
      ];
    };
    defaultGateway = "172.28.48.1";
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
  };
}
