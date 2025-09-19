{pkgs, ...}:
#let
#secrets = import ./../secrets.nix;
#in
{
  environment.systemPackages = with pkgs; [
    pigz
  ];
  services = {
    openssh = {
      enable = true;
      ports = [6000];
      settings.PasswordAuthentication = false;
    };
    fail2ban.enable = true;
    #tailscale.enable = true; # not needed right now
  };
  networking = {
    firewall.allowedTCPPorts = [
      6000
    ];
  };
}
