# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "frost";

    #wireguard = (import ../../utils/wireguard.nix) {
    #  ip = "10.242.0.3/32";
    #};
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Budapest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  services.fwupd = {
    enable = true;
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,hu";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.fprintd = {
    enable = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.libinput = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.easimer = {
    isNormalUser = true;
    description = "easimer";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
    ];
    packages = with pkgs; [
      kdePackages.kate
      ghostty
      kdePackages.kclock
      qbittorrent
      mpv
      teams-for-linux
      # Install J-Link just for the udev rules. The real j-link dlls will be
      # installed under the zephyr workspace
      (pkgs.segger-jlink.override {
        headless = true;
      })
      nrfconnect
      nrfconnect-bluetooth-low-energy
      nrf-udev

      gdb
      gf
      valgrind
      renderdoc
    ];
  };

  programs.steam = {
    enable = true;
  };

  # Install firefox.
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;

      ExtensionSettings = {
        "*".installation_mode = "blocked";
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Accept the license of J-Link
  nixpkgs.config.segger-jlink.acceptLicense = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    pciutils
    usbutils
  ];

  services.openssh = {
    enable = true;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
    ];

    fcitx5.settings.inputMethod = {
      "Groups/0" = {
        Name = "Default";
        "Default Layout" = "us";
        DefaultIM = "mozc";
      };
      "Groups/0/Items/0".Name = "keyboard-us";
      "Groups/0/Items/1".Name = "mozc";

      "Groups/1" = {
        Name = "Hu";
        "Default Layout" = "hu";
        DefaultIM = "";
      };

      GroupOrder."0" = "Default";
      GroupOrder."1" = "Hu";
    };

    fcitx5.waylandFrontend = true;
  };

  hardware.bluetooth = {
    enable = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
