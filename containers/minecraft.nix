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
        eula = true;
        openFirewall = true;
        servers = {
          servernamegoeshere = {
            enabled = true;
            package = pkgs.fabricServers.fabric-1_20_1;

            serverProperties = {};
            whitelist = {};
            symlinks = {
              "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
                fabric-api = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/UapVHwiP/fabric-api-0.92.6%2B1.20.1.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };
                lithium-fabric = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/iEcXOkz4/lithium-fabric-mc1.20.1-0.11.4.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };
                FerriteCore = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/uXXizFIs/versions/unerR5MN/ferritecore-6.0.1-fabric.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };
                Krypton = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/jiDwS0W1/krypton-0.2.3.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };
                Veinminer = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/OhduvhIc/versions/PSctVdKm/Veinminer-2.0.7.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Silk = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/aTaCgKLW/versions/3H0nUJhq/silk-all-1.10.1.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Farmers-Delight-Refabricated = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/7vxePowz/versions/Z8UNayLO/FarmersDelight-1.20.1-2.4.1%2Brefabricated.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Distant-Friends = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/CDaJ8xGu/versions/ElfqWcKI/DistantFriends-fabric-1.20.1-0.5.5.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Create-Fabric = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/Xbc0uyRg/versions/HAqwA6X1/create-fabric-6.0.8.1%2Bbuild.1744-mc1.20.1.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Steam-n-Rails = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/ZzjhlDgM/versions/VFhdqLko/Steam_Rails-1.6.9%2Bfabric-mc1.20.1.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Create-Crafts-n-Additions = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/kU1G12Nn/versions/Y3djqUGn/createaddition-fabric%2B1.20.1-1.3.3.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Copycats = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/UT2M39wf/versions/WYmjbo0H/copycats-2.2.2%2Bmc.1.20.1-fabric.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Create-Slice-n-Dice = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/GmjmRQ0A/versions/EzpVcwYV/sliceanddice-fabric-3.3.1.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };
                Create-Deco = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/sMvUb4Rb/versions/GsxgfeNu/createdeco-2.0.2-1.20.1-fabric.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Create-Big-Cannons = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/GWp4jCJj/versions/LTezmxKD/createbigcannons-5.10.0%2Bmc.1.20.1-fabric.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };
                Create-Structures = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/IAnP4np7/versions/nqsTHZwx/create-structures-0.1.1-1.20.1-FABRIC.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };
                Create-Interactive = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/MyfCcqiE/versions/66F5LBos/create_interactive-1.1.1-beta.4_1.20.1-fabric.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Create-Numismatics = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/Jdbbtt0i/versions/SJpLT0Bq/CreateNumismatics-1.0.15%2Bfabric-mc1.20.1.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };

                Create-Aquatic-Ambitions = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/9SyaPzp7/versions/RFho1G3m/create_aquatic_ambitions-fabric-1.1.2%2B1.20.1.jar";
                  sha256 = "..."; # nix-prefetch-url <url>
                };
              });
            };
          };

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
            enable = false;
            package = pkgs.fabricServers.fabric-1_20_1;
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
