{ config, pkgs, ... }:
{
  imports = [
    ../../systems/hyperv
    ./hardware-configuration.nix
    ../../utils/vscode-server
  ];

  networking.hostName = "hell-hyperv";
}
