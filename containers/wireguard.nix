{...}: {
  #containers.wireguard = {
  #autoStart = true;
  #privateNetwork = false;
  #config = {
  #pkgs,
  #lib,
  #...
  #}: {
  networking.wireguard.interfaces.wg0 = {
    privateKeyFile = "/etc/wireguard/private";
    listenPort = 51820;
    ips = ["10.0.0.1/24"];
    peers = [
      {
        publicKey = "vWCeMXGBA2v5bV+kX/otvPi/+v9DSAzKnrBqqbbB31k="; # hexolexo
        allowedIPs = ["10.0.0.2/32"];
      }
      {
        publicKey = "LIOuTaH9hb6tVrQHADclTFnCcRFD9DHjaVbNSevfGxc="; # toshi
        persistentKeepalive = 25;
        allowedIPs = ["10.0.0.3/32"];
      }
      {
        publicKey = "v54b/A7ynLrcXBMcgJkf6vgzJgra8Z3BkaFHMy1RMWk="; # death
        allowedIPs = ["10.0.0.4/32"];
      }
      {
        publicKey = "KsWkLxtO3pbgeolMGpF1PhuMTg9vfcZ2GuPUyoYT6Xg="; # Euroacorn
        allowedIPs = ["10.0.0.5/32"];
      }
      {
        publicKey = "ePTxrL7Fgqdl6HO/ZImMHMLnXBysGQ8+h0t+6pBJiRE="; # guest
        allowedIPs = ["10.0.0.6/32"];
      }
    ];
  };
  networking.firewall.allowedUDPPorts = [51820];

  #boot.isContainer = true;
  #system.stateVersion = "25.05";
  #};
  #};
}
