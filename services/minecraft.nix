{
  pkgs,
  nix-minecraft,
  ...
}: {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers = {
      servernamegoeshere = {
        enable = true;
        package = nix-minecraft.legacyPackages.${pkgs.system}.fabricServers.fabric-1_20_1;

        jvmOpts = [
          "-Xmx12G"
          "-Xms12G"
        ];

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

        symlinks = {
          "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            fabric-api = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/UapVHwiP/fabric-api-0.92.6%2B1.20.1.jar";
              sha256 = "1syyfxwybcsa0kyfwsfhikcp13j5qm2mkdq4mc8j2sd3dm3m1khf";
            };
            fabric-kotlin = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/LcgnDDmT/fabric-language-kotlin-1.13.7%2Bkotlin.2.2.21.jar";
              sha256 = "1wmqnhcwh9b7knsg69iljxdy8wd88ryy6x7iwizd7mymxmiik5bp";
            };
            cloth-config-api = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/9s6osm5g/versions/2xQdCMyG/cloth-config-11.1.136-fabric.jar";
              sha256 = "1yj9bji8sd290xd2h9jf0mqxbw2r01yipcks2r719wy8771ljkw4";
            };

            lithium-fabric = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/iEcXOkz4/lithium-fabric-mc1.20.1-0.11.4.jar";
              sha256 = "10p75n8ci8lxjzafrqc04l71gsvxa4k9wbanfp7hgadfjbz3w4vn";
            };
            FerriteCore = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/uXXizFIs/versions/unerR5MN/ferritecore-6.0.1-fabric.jar";
              sha256 = "096gpswpj4l5icwm2ppyrb1kwgks07hznsf3s40ajbavl0c13fn7";
            };
            Krypton = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/jiDwS0W1/krypton-0.2.3.jar";
              sha256 = "163n0l4n5hzaap39cv63h43jazjf0h7n90xhn60j3qbc4081ibb9";
            };
            Veinminer = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/OhduvhIc/versions/PSctVdKm/Veinminer-2.0.7.jar";
              sha256 = "1iqj2vvd6ygkkwhabbmwqvyih95yr1548inr3gvbbyz3fpipqviw";
            };

            Silk = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/aTaCgKLW/versions/3H0nUJhq/silk-all-1.10.1.jar";
              sha256 = "0f23z68c412nmvx1y1fimx3471h64mwzllq7q8d0bnrmc7vad2il";
            };

            Farmers-Delight-Refabricated = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/7vxePowz/versions/Z8UNayLO/FarmersDelight-1.20.1-2.4.1%2Brefabricated.jar";
              sha256 = "1b4ghbq38yi3c68yh23rqgpjf8dchradwcj9pvzhn8lfnl88xmw1";
            };

            Distant-Friends = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/CDaJ8xGu/versions/ElfqWcKI/DistantFriends-fabric-1.20.1-0.5.5.jar";
              sha256 = "1163sgzf77wcl6cjmq7dnj8fqns2p8l21ysp5bv96hn4gf0a0877";
            };

            Create-Fabric = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Xbc0uyRg/versions/HAqwA6X1/create-fabric-6.0.8.1%2Bbuild.1744-mc1.20.1.jar";
              sha256 = "0nhh817zyk4sawhzx2g4j5xk8jjc6yvsvl9q85d7r5ldn0zn04x6";
            };

            #Steam-n-Rails = pkgs.fetchurl {
            #url = "https://cdn.modrinth.com/data/ZzjhlDgM/versions/VFhdqLko/Steam_Rails-1.6.9%2Bfabric-mc1.20.1.jar";
            #sha256 = "1rawk1i82pp1b0xz55nr5b8zxl5b873yrd62ywlz320ndjimzwrq";
            #};

            #Create-Crafts-n-Additions = pkgs.fetchurl {
            #url = "https://cdn.modrinth.com/data/kU1G12Nn/versions/Y3djqUGn/createaddition-fabric%2B1.20.1-1.3.3.jar";
            #sha256 = "1iixh9lcg422z9dsm80235xahr408m8x07nix39sqcndhk56za5c";
            #};

            #Copycats = pkgs.fetchurl {
            #url = "https://cdn.modrinth.com/data/UT2M39wf/versions/WYmjbo0H/copycats-2.2.2%2Bmc.1.20.1-fabric.jar";
            #sha256 = "01wl0dp6zbgssk07rym4byd1s9bbyb09gic8s97bmgw37mppqs9y";
            #};

            #Create-Slice-n-Dice = pkgs.fetchurl {
            #url = "https://cdn.modrinth.com/data/GmjmRQ0A/versions/EzpVcwYV/sliceanddice-fabric-3.3.1.jar";
            #sha256 = "08f53yvwd62w1y4ybqjxm8cr1mpnk4x2xzwnaxnyig0d6jcgca5r";
            #};
            #Create-Deco = pkgs.fetchurl {
            #url = "https://cdn.modrinth.com/data/sMvUb4Rb/versions/GsxgfeNu/createdeco-2.0.2-1.20.1-fabric.jar";
            #sha256 = "1wq1777bc62d4pgpip7sllbcwc5rln6d0ssbsbyl7nxzakjrrysr";
            #};

            #Create-Big-Cannons = pkgs.fetchurl {
            #url = "https://cdn.modrinth.com/data/GWp4jCJj/versions/LTezmxKD/createbigcannons-5.10.0%2Bmc.1.20.1-fabric.jar";
            #sha256 = "052v6fb7zizas16c1p770n4ig417yf47vzijq0ncn82b9yf1b02p";
            #};
            Create-Structures = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/IAnP4np7/versions/nqsTHZwx/create-structures-0.1.1-1.20.1-FABRIC.jar";
              sha256 = "1xmlkp5wqa2kgfspg37niffd5i6hw9vv5nmgnkm1bq9j0aha6rri";
            };
            #Create-Interactive = pkgs.fetchurl {
            #url = "https://cdn.modrinth.com/data/MyfCcqiE/versions/66F5LBos/create_interactive-1.1.1-beta.4_1.20.1-fabric.jar";
            #sha256 = "0sq0gl886m3sjzvwbamqay92qgnfni1kk8hq8wv58kcq5dfbmib5";
            #};

            Create-Numismatics = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Jdbbtt0i/versions/SJpLT0Bq/CreateNumismatics-1.0.15%2Bfabric-mc1.20.1.jar";
              sha256 = "1j92cmfggnixmh6wgjswz7fw0811lhjippzf8r851i6vlx4grxmk";
            };

            #Create-Aquatic-Ambitions = pkgs.fetchurl {
            #url = "https://cdn.modrinth.com/data/9SyaPzp7/versions/RFho1G3m/create_aquatic_ambitions-fabric-1.1.2%2B1.20.1.jar";
            #sha256 = "1gjvbnl8gycckfjwbsch50ihyvpv3xvfnis5p3qsi6cz6000ixxs";
            #};
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
          server-port = 25566;
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
}
