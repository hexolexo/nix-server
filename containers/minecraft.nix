{ config, lib, pkgs, ... }:

{
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

        config = { config, lib, pkgs, modulesPath, ... }: 
            let
                nix-minecraft = builtins.getFlake "github:Infinidoge/nix-minecraft";
            in {
                nix.settings.experimental-features = [ "nix-command" "flakes" ];

                system.stateVersion = "25.05";
                nixpkgs.config.allowUnfree = true;

                imports = [ nix-minecraft.nixosModules.minecraft-servers ];
                nixpkgs.overlays = [ nix-minecraft.overlay ];

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
                                # Memory limits
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
                            #symlinks =  {
                            #“mods” = pkgs.linkFarmFromDrvs “mods” (builtins.attrValues {
                                    #   Starlight = fetchurl { url = “https://cdn.modrinth.com/data/H8CaAYZC/versions/XGIsoVGT/starlight-1.1.2%2Bfabric.dbc156f.jar”; sha512 = “6b0e363fc2d6cd2f73b466ab9ba4f16582bb079b8449b7f3ed6e11aa365734af66a9735a7203cf90f8bc9b24e7ce6409eb04d20f84e04c7c6b8e34f4cc8578bb”; };
                                    #   Lithium = fetchurl { url = “https://cdn.modrinth.com/data/gvQqBUqZ/versions/ZSNsJrPI/lithium-fabric-mc1.20.1-0.11.2.jar”; sha512 = “d1b5c90ba8b4879814df7fbf6e67412febbb2870e8131858c211130e9b5546e86b213b768b912fc7a2efa37831ad91caf28d6d71ba972274618ffd59937e5d0d”; };
                                    #   FerriteCore = fetchurl { url = “https://cdn.modrinth.com/data/uXXizFIs/versions/ULSumfl4/ferritecore-6.0.0-forge.jar”; sha512 = “e78ddd02cca0a4553eb135dbb3ec6cbc59200dd23febf3491d112c47a0b7e9fe2b97f97a3d43bb44d69f1a10aad01143dcd84dc575dfa5a9eaa315a3ec182b37”; };
                                    #   Krypton = fetchurl { url = “https://cdn.modrinth.com/data/fQEb0iXm/versions/jiDwS0W1/krypton-0.2.3.jar”; sha512 = “92b73a70737cfc1daebca211bd1525de7684b554be392714ee29cbd558f2a27a8bdda22accbe9176d6e531d74f9bf77798c28c3e8559c970f607422b6038bc9e”; };
                                    #   LazyDFU = fetchurl { url = “https://cdn.modrinth.com/data/hvFnDODi/versions/0.1.3/lazydfu-0.1.3.jar”; sha512 = “dc3766352c645f6da92b13000dffa80584ee58093c925c2154eb3c125a2b2f9a3af298202e2658b039c6ee41e81ca9a2e9d4b942561f7085239dd4421e0cce0a”; };
                                    #   C2ME = fetchurl { url = “https://cdn.modrinth.com/data/VSNURh3q/versions/t4juSkze/c2me-fabric-mc1.20.1-0.2.0%2Balpha.10.91.jar”; sha512 = “562c87a50f380c6cd7312f90b957f369625b3cf5f948e7bee286cd8075694a7206af4d0c8447879daa7a3bfe217c5092a7847247f0098cb1f5417e41c678f0c1”; };
                            #});
                            #};
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

                networking.firewall.allowedTCPPorts = [ 25565 ];

                # Ensure minecraft directory has correct permissions
                systemd.tmpfiles.rules = [
                    "d /var/lib/minecraft 755 minecraft minecraft -"
                ];
            };
    };

    # Host firewall - forward port to container
    networking.firewall.allowedTCPPorts = [ 25565 ];
}
