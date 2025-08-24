{...}: {
  containers.headscale = {
    autoStart = true;
    privateNetwork = false;
    config = {
      pkgs,
      lib,
      ...
    }: let
      domain = "vault.lan:18080";
    in {
      users.groups.headnet = {};
      users.users.headnet = {
        isNormalUser = true;
        group = "headnet";
        home = "/home/headnet";
        createHome = true;
      };
      services.headscale = {
        enable = true;
        address = "0.0.0.0";
        port = 18080;

        settings = {
          server_url = "https://${domain}";
          dns = {
            base_domain = "nexus.local";
            # Enable MagicDNS
            #nameservers = [ "1.1.1.1" "8.8.8.8" ];
          };
          logtail.enabled = false;

          # Custom IP ranges
          ip_prefixes = [
            "fd7a:115c:a1e0::/48" # IPv6 prefix
            "100.64.0.0/10" # IPv4 prefix
          ];

          # Disable key expiry (optional)
          disable_check_updates = true;

          # Custom log level
          log_level = "info";
        };
      };

      networking.firewall.allowedTCPPorts = [18080];
      boot.isContainer = true;
      system.stateVersion = "25.05";
    };
  };
  networking.firewall.allowedTCPPorts = [18080];
}
