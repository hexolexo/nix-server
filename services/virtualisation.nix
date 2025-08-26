{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = [pkgs.OVMFFull.fd];
    };
  };

  networking = {
    nat = {
      enable = true;
      internalInterfaces = ["virbr0" "virbr1"];
      externalInterface = "enp0s25"; # or your main interface name
    };
    # Enable IP forwarding (required for NAT)
    firewall.checkReversePath = "loose";

    # Trust the libvirt bridge
    firewall.trustedInterfaces = ["virbr0" "virbr1"];

    # Allow forwarding
    #firewall.extraCommands = ''
    #iptables -I FORWARD -m physdev --physdev-is-bridged -j ACCEPT
    #'';
  };
  services.dnsmasq.enable = false;

  users.users.hexolexo = {
    extraGroups = ["libvirtd"];
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    bridge-utils
    nftables
  ];

  # Ensure proper service ordering
  systemd.services.libvirtd = {
    path = with pkgs; [
      qemu_kvm
      nftables
      cdrkit
      dosfstools
      cdrkit
      opentofu
      bridge-utils
    ];
  };
}
