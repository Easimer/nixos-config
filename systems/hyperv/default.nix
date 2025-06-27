#
# System config for NixOS installed in a Hyper-V VM.
#

{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [
    "hv_vmbus"
    "hv_storvsc"
  ];
  boot.kernelParams = [ "video=hyperv_fb:800x600" ];
  boot.kernel.sysctl."vm.overcommit_memory" = "1";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = false;

  users.users.easimer = {
    isNormalUser = true;
    description = "easimer";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  services.openssh.enable = true;
  users.users."easimer".openssh.authorizedKeys.keyFiles = [
    ../authorized_keys
  ];

  # Disable firewall. System is expected to be connected to a virtual switch
  # and is only reachable from the host.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
