{ config, pkgs, ... }:

{
  # Enable Cockpit
  services.cockpit = {
    enable = true;
    port = 9091;  # Default port, can be changed if needed
  };

  # Open firewall port for Cockpit
  networking.firewall = {
    allowedTCPPorts = [ 9091 ];
  };

  # Optional: Install additional Cockpit modules
  environment.systemPackages = with pkgs; [
    cockpit
  ];

  # Ensure necessary services are enabled
  services.udisks2.enable = true;  # For storage management
      boot.kernelModules = [ "kvm-intel" ];
    virtualisation.libvirtd = {
        onShutdown = "shutdown";
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = false;
            swtpm.enable = true;  # Enable TPM emulation
            ovmf = {
                enable = true;
                packages = [ pkgs.OVMFFull.fd ];
            };
        };
    };
    boot.kernel.sysctl."vm.nr_hugepages" = 4096;

}
