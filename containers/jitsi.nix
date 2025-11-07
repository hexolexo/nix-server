{...}: {
  containers.jitsi = {
    autoStart = true;
    config = {
      pkgs,
      lib,
      ...
    }: {
      services.jitsi-meet = {
        enable = true;
        hostName = "10.0.0.1"; # or your server IP
        config = {
          enableWelcomePage = true;
          prejoinPageEnabled = false; # Skip the lobby
        };
      };

      networking.firewall.allowedTCPPorts = [80 443 10000];
      networking.firewall.allowedUDPPorts = [10000];

      system.stateVersion = "25.05";
    };
  };

  networking.firewall.allowedTCPPorts = [8096];
}
