{pkgs, ...}: {
  systemd.services.deploy-watchdog = {
    description = "Reboot if deploy fails";
    script = ''
      sleep 120
      while ${pkgs.procps}/bin/pgrep nixos-rebuild; do sleep 10; done
      ${pkgs.systemd}/bin/reboot
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
