{ pkgs, ... }: {
    containers.i2p-container = {
        autoStart = true;
        privateNetwork = false;
        bindMounts = {
            "/var/lib/i2p" = {
                hostPath = "/var/lib/containers/i2p";
                isReadOnly = false;
            };
        };
        config = { ... }: {
            users.users.i2p-tunnel = {
                isNormalUser = true;
                description = "I2P tunnel user for port forwarding";
                extraGroups = [ ];
                shell = pkgs.shadow;
                openssh.authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGlEF74+sZlOXp1uyqIArE+yVdgPKePLmjwiO4dkp8fe anon@nixos"
                ];
            };
            # Enable SSH service inside the container
            services.openssh = {
                enable = true;
                ports = [ 2222 ];
                settings = {
                    AllowTcpForwarding = true;
                    ForceCommand = "/run/current-system/sw/bin/sleep infinity";
                    GatewayPorts = "yes";
                    PasswordAuthentication = true;
                    PermitRootLogin = "no";
                };
            };

            # Exposing the necessary ports in order to interact with i2p from outside the container
            networking.firewall = {
                allowedUDPPorts = [
                    10881 # This one changes often
                ];
                allowedTCPPorts = [
                    2222 # SSH port for forwarding
                    7657
                    #7070 # default web interface port
                    4447 # default socks proxy port
                    4445
                    4444 # default http proxy port
                    10881 # This one changes often
                ];
            };
            services.i2p.enable = true;
            system.stateVersion = "25.05"; # If you don't add a state version, nix will complain at every rebuild
        };
    };
    networking.firewall = {
        allowedUDPPorts = [
            10881 # This one changes often
        ];
        allowedTCPPorts = [
            2222 # SSH port for forwarding
            10881 # This one changes often
        ];
        extraCommands = ''
        iptables -A INPUT -p tcp --dport 2222 -s 192.168.122.0/24 -j ACCEPT
        iptables -A INPUT -p tcp --dport 2222 -j DROP
        '';
    };
}
