{...}: {
  containers.wireguard = {
    autoStart = true;
    privateNetwork = false;
    config = {
      pkgs,
      lib,
      ...
    }: {
      networking.wireguard.interfaces.wg0 = {
        privateKeyFile = "/etc/wireguard/private";
        listenPort = 51820;
        ips = ["10.0.0.1/24" "192.168.1.108/32"];
        peers = [];
      };
      networking.firewall.allowedUDPPorts = [51820];

      boot.isContainer = true;
      system.stateVersion = "25.05";
    };
  };
}
