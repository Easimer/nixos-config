{
  ip,
}:
{
  enable = true;

  interfaces.wg0 = {
    ips = [ ip ];
    privateKeyFile = "/home/easimer/.config/wgpk";

    peers = [
      {
        endpoint = "23.88.43.220:51820";
        publicKey = "nTJ2Xx3iGn3b2O66a/8SGaUAn36xkGBx3VzvkAdrbQk=";
        allowedIPs = [
          "10.242.0.0/24"
        ];
      }
    ];
  };
}
