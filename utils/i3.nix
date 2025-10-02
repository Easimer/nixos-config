{
  inputs,
  pkgs,
  ...
}:
{
  config = {
    services.xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = false;
        sddm.enable = false;
      };
      desktopManager = {
        xterm.enable = false;
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3;
        extraPackages = with pkgs; [
          dmenu
          i3status
          alacritty
        ];
      };

    };

    services.xrdp = {
      enable = true;
      defaultWindowManager = "${pkgs.i3}/bin/i3";
      openFirewall = true;
    };
  };
}
