{
pkgs,
config,
lib,
...
}: {
    # Soft Serve Git server
    services.soft-serve = {
        enable = true;
        settings = {
            name = "hexolexo's repos";
            description = "hexolexo's local repos";
            host = "192.168.0.88";
            port = 23231;
            initial_admin_keys = [
                "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCust8pSGquicM7xzgZgMpuKvC6cLc6pXHlyUNxOh33lrT3vHDH5lNYNB8Bn1tN1nhI1Rug0leuAZ9smzcwoXNChClOlUV2szs+zndC03wkQDWYRRHASGMlEbi1XA1MBlE3btXkuwAvAwI5ikLrZ+Xuflq551xlmhOLfDwtFsUVyEiZk8CtsadFCN49NNgZixDU5QK4Y6ABDdoNZxyHu/paAYrwypNRZdIvR8rn/uGW4rxclP5kdkHnikxsus1ztcAF42tF4eNC+TKe2k/FpgDfcEietCmUI5f/SEAZ6zFSITgVv03zrGsnPIUmbsEike4xVKv0lN8jlZnOTVcqGCno7NjouWhhYdI+RatwBi8y7LJdcrqMa9b71Cv6ekKRH3wV6rSHhJySfn2TfqQQkUh8ajwLov758czOe22wBPcoJCwOAwxhJSYfZcqdSzjH/8iXrGn8NOo/AMYXSI+scyepgXC6rEWHeL9AYRSqLjydwH62a+PWX2xEWQU3FMRzoDU= hexolexo@hexolexo"
            ];
        };

    };

    # Open firewall ports for local access
    networking.firewall = {
        allowedTCPPorts = [ 
            23231  # Soft Serve Git SSH
        ];
    };

    # System packages
    environment.systemPackages = with pkgs; [
        soft-serve
        docker-compose
        git
        curl
    ];

    # Git user for soft-serve
    users.users.git = {
        isSystemUser = true;
        home = "/var/lib/soft-serve";
        group = "git";
        createHome = true;
    };
    users.groups.git = {};

    systemd.services.soft-serve = {
        serviceConfig = {
            DynamicUser = pkgs.lib.mkForce false;
            User = "git";
            Group = "git";
        };
    };
}
