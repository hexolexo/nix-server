{pkgs, ...}:
#let
#secrets = import ./../secrets.nix;
#in
{
  environment.systemPackages = with pkgs; [
    pigz
  ];
  services = {
    #go-shadowsocks2 = {
    #server.enable = true;
    #server.listenAddress = "ss://AEAD_CHACHA20_POLY1305:${secrets.shadowsocksPassword}@:${secrets.shadowsocksPort}";
    #};
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
      #4403 # 443 redirects to here # via the router
      6000 # OpenSSH - Port Forwarded
    ];
  };
}
