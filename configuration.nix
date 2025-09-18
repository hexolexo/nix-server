{pkgs, ...}: let
  secrets = import ./secrets.nix;
in {
  imports = [
    # Required Services #
    ./hardware-configuration.nix
    ./services/connection.nix
    ./services/wireguard.nix
    ./services/git.nix
    ./services/virtualisation.nix
    # Optional Services: #
    ./services/paperless-ngx.nix
    #./containers/minecraft.nix     # It's been a while since the last weeklong mc obsession with friends
    #./containers/mindustry.nix
    #./containers/terraria.nix      #  WARN: No clue if this one works
    #./containers/I2P.nix           #  BUG: I think my ISP is blocking I2P
    #./containers/jellyfin.nix
    #./containers/fuzzing.nix       #  NOTE: I'll probably want to start using this at some point
    #./containers/monitoring.nix    #  NOTE: Functional but uses to many resources for a simple project like this
    #./services/cockpit.nix         #  WARN: Currently broken (And honestly will probably stay that way
    #./containers/tarpit.nix
  ];

  # Bootloader.
  boot = {
    enableContainers = true;
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  users.users = {
    hexolexo = {
      isNormalUser = true;
      description = "hexolexo";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [go];
      openssh.authorizedKeys.keys = [
        "${secrets.sshKey}"
      ];
    };
    root.openssh.authorizedKeys.keys = [
      "${secrets.sshKey}"
    ];
  };

  environment.systemPackages = with pkgs; [
    btop
    git
    micro
    cargo
    pkg-config
    alsa-lib.dev
    clang
  ];

  services.ntp = {
    enable = true;
    servers = [
      "0.au.pool.ntp.org"
      "1.au.pool.ntp.org"
      "2.au.pool.ntp.org"
      "3.au.pool.ntp.org"
    ];
  };

  networking = {
    hostName = "vault";
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = []; #  NOTE: Firewall is configured per service bundle
  };

  system.autoUpgrade = {
    enable = true;
    dates = "16:00"; #  NOTE: I'll dial this back when I get busy
    allowReboot = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
    settings = {
      experimental-features = ["nix-command" "flakes"];
      max-jobs = 20;
      cores = 0;
      auto-optimise-store = true;
    };
  };

  system.stateVersion = "25.05";
}
