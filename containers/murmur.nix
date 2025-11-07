{...}: {
  containers.jitsi = {
    autoStart = true;
    config = {
      pkgs,
      lib,
      ...
    }: {
      services.murmur = {
        enable = true;
        openFirewall = true;
        #password = "your-server-password"; # Optional server password
      };
      system.stateVersion = "25.05";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [64738];
    allowedUDPPorts = [64738];
  };
}
