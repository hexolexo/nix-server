{...}: {
  networking.wireguard.interfaces.wg0 = {
    privateKeyFile = "/etc/wireguard/private";
    listenPort = 51820;
    ips = ["10.0.0.1/24"];
    peers = [
      {
        publicKey = "vWCeMXGBA2v5bV+kX/otvPi/+v9DSAzKnrBqqbbB31k="; # hexolexo
        allowedIPs = ["10.0.0.2/32"];
      }
      #{
      #publicKey = "LIOuTaH9hb6tVrQHADclTFnCcRFD9DHjaVbNSevfGxc="; # toshi
      #persistentKeepalive = 25;
      #allowedIPs = ["10.0.0.3/32"];
      #}
      #{
      #publicKey = "v54b/A7ynLrcXBMcgJkf6vgzJgra8Z3BkaFHMy1RMWk="; # death
      #persistentKeepalive = 25;
      #allowedIPs = ["10.0.0.4/32"];
      #}
      #{
      #publicKey = "KsWkLxtO3pbgeolMGpF1PhuMTg9vfcZ2GuPUyoYT6Xg="; # Euroacorn
      #allowedIPs = ["10.0.0.5/32"];
      #}
      #{
      #publicKey = "ePTxrL7Fgqdl6HO/ZImMHMLnXBysGQ8+h0t+6pBJiRE="; # guest
      #allowedIPs = ["10.0.0.6/32"];
      #}
      {
        publicKey = "7dfeqJu3P6toUdHD73g6c8j/SZyhhHGaUpXSPP3reng="; # phone
        allowedIPs = ["10.0.0.7/32"];
      }
      #{
      #publicKey = "vYJqxIRzAw79kVV1gdca5R31GnZVjx1PtT0tmh8jSis="; # beco
      #allowedIPs = ["10.0.0.8/32"];
      #}
      #{
      #publicKey = "tEqrq/OG096keu34qiTjuEdS4C87hxy5NkrmloVKyHY="; # sticklegs
      #allowedIPs = ["10.0.0.9/32"];
      #}
      #{
      #publicKey = "3kXYxT2uOFigoEhFzTt7X63MSt0Vt9v9/cI+z/HxVAY="; # beco-server
      #allowedIPs = ["10.0.0.10/32"];
      #}
      #{
      #publicKey = "WHTgVz8DligoY53aAMHOso5UfTI3PfdPT+SVP1A+dQw="; # tempr
      #allowedIPs = ["10.0.0.11/32"];
      #}
    ];
  };
  networking.firewall.allowedUDPPorts = [51820];
}
