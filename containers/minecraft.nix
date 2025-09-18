{...}: {
  containers.minecraft = {
    autoStart = true;
    bindMounts = {
      "/var/lib/minecraft" = {
        hostPath = "/var/lib/containers/minecraft";
        isReadOnly = false;
      };
    };
    forwardPorts = [
      {
        containerPort = 25565;
        hostPort = 25565;
        protocol = "tcp";
      }
    ];

    config = {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }: let
      nix-minecraft = builtins.getFlake "github:Infinidoge/nix-minecraft";
    in {
      nix.settings.experimental-features = ["nix-command" "flakes"];

      system.stateVersion = "25.05";
      nixpkgs.config.allowUnfree = true;

      imports = [nix-minecraft.nixosModules.minecraft-servers];
      nixpkgs.overlays = [nix-minecraft.overlay];

      users.users.minecraft = {
        isSystemUser = true;
        group = "minecraft";
        home = lib.mkForce "/var/lib/minecraft";
        createHome = true;
      };
      users.groups.minecraft = {};

      services.minecraft-servers = {
        enable = true;
        eula = true;
        openFirewall = true;
        servers = {
          meAndTheBois = {
            jvmOpts = [
              # Memory limits #  TODO: really gotta learn JVMopts
              "-Xmx12G"
              "-Xms12G"

              # Security Manager (if compatible with your mods)
              #"-Djava.security.manager=default"
              #"-Djava.security.policy=/var/lib/minecraft/security.policy"

              # Disable dangerous JVM features
              #"-Djava.awt.headless=true"
              #"-Dcom.sun.management.jmxremote=false"
              #"-Djava.rmi.server.useCodebaseOnly=true"
              #"-Dcom.sun.jndi.rmi.object.trustURLCodebase=false"
              #"-Dcom.sun.jndi.cosnaming.object.trustURLCodebase=false"

              # Prevent JVM from creating core dumps
              #"-XX:-CreateCoredumpOnCrash"

              # Disable JIT compilation logs
              #"-XX:-PrintCompilation"
              #"-XX:-TraceClassLoading"
            ];
            enable = true;
            package = pkgs.fabricServers.fabric-1_21_7;
            serverProperties = {
              server-port = 25565;
              gamemode = 0;
              difficulty = 3;
              white-list = true;
              level-seed = "Toshi is a Femboy";
              max-players = 10;
              view-distance = 24;
            };
            whitelist = {
              hexolexo = "080aa9de-bcf6-4f3d-8e5d-a86f4977885a";
              ToshiiChu = "fd2b9565-56a6-45f4-a062-408633d9efc5";
              I_Am_Jam = "e84a7fab-0861-464d-81e3-ed8bda07795f";
              Circle_Yuh = "786069e6-8d7e-466a-9363-45a6734e6aff";
              Beco100 = "fea5630f-000f-4020-92ec-a15227730706";
              sticklegs900 = "ef354591-75cf-4a83-acd8-da5f2b36b8ac";
              Goodgamer1900 = "7236b3a1-8994-4908-a4f9-c75a5fb2fcf2";
            };
          };
        };
      };

      networking.firewall.allowedTCPPorts = [25565];

      systemd.tmpfiles.rules = [
        "d /var/lib/minecraft 755 minecraft minecraft -"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [25565];
}
