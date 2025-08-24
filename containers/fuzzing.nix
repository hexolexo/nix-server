{...}: {
  containers.fuzzing = {
    autoStart = true;
    privateNetwork = false;
    config = {
      pkgs,
      lib,
      ...
    }: {
      users.groups.fuzzy = {};
      users.users.fuzzy = {
        isNormalUser = true;
        group = "fuzzy";
        home = "/home/fuzzy";
        createHome = true;
      };
      environment.systemPackages = with pkgs; [
        # aflplusplus # Requires modification of kernel params
        honggfuzz
        radamsa
        clang
        gdb
        go
        gcc
        gnumake
        wget
        python3
        git
        strace
        valgrind
        hexdump
        binutils
        micro
      ];
      services.getty.autologinUser = "fuzzy";

      boot.isContainer = true;

      systemd.tmpfiles.rules = [
        "d /tmp/cores 1777 root root -"
      ];
      system.stateVersion = "25.05";
    };
  };
}
