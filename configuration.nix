{pkgs, ...}: let
  secrets = import ./secrets.nix;
in {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #./containers/minecraft.nix
    #./containers/terraria.nix
    #./containers/I2P.nix
    #./containers/jellyfin.nix
    #./containers/benchmark.nix
    ./containers/fuzzing.nix
    ./services/connection.nix
    ./containers/monitoring.nix
    #./services/duckdns.nix # unfinished
    #./services/step-ca.nix
    ./containers/headscale.nix
    #./services/frigate-nvr.nix
    ./services/git.nix
    ./services/virtualisation.nix
    ./services/paperless-ngx.nix
    #./services/cockpit.nix
    ./containers/honeypot.nix
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
  #boot = {
  #enableContainers = true;
  #loader = {
  #grub.enable = true;
  #grub.device = "/dev/sda";
  #grub.useOSProber = true;
  #};
  ## tmp.cleanOnBoot = true; # This might clean out run and/or var which could be a massive issue
  #};

  # Set your time zone.
  time.timeZone = "Australia/Sydney";
  # Select internationalisation properties.
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
    hostName = "vault"; # Define your hostname.
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = []; # Firewall is configured per service bundle
  };

  system.autoUpgrade = {
    enable = true;
    dates = "16:00";
    allowReboot = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };
  nix.settings = {
    max-jobs = 20;
    cores = 0;
    auto-optimise-store = true;
  };
  system.stateVersion = "25.05";
}
