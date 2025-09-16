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
  };
  services.dnsmasq.enable = false;

  users.users.hexolexo = {
    extraGroups = ["libvirtd"];
  };

  services.prometheus.exporters.libvirt = {
    enable = true;
    user = "hexolexo";
    group = "libvirtd";

    port = 9101;
    listenAddress = "127.0.0.1";
    libvirtUri = "qemu:///system";
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    cdrkit
    dosfstools
    opentofu
    libxslt # tofu window xml dependency
    win-virtio
    win-spice
    bridge-utils
    nftables
    # Ansible
    ansible
    python3Packages.pywinrm # Required for Windows management
    python3Packages.requests-ntlm # For NTLM authentication
    python3Packages.requests-credssp # For CredSSP authentication
  ];

  # Ensure proper service ordering
  systemd.services.libvirtd = {
    path = with pkgs; [
      qemu_kvm
      nftables
      bridge-utils
    ];
  };
}
