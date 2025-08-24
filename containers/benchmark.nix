{ ... }: {
    containers.benchmark = {
        autoStart = true;
        privateNetwork = false;
        config = { pkgs, lib, ... }: {
            nixpkgs.config.allowUnfree = true;
            users.groups.benchy = {};
            users.users.benchy = {
                isNormalUser = true;
                group = "benchy";
                home = "/home/benchy";
                createHome = true;
            };
            environment.systemPackages = with pkgs; [
                cinebench
            ];

            boot.isContainer = true;

            system.stateVersion = "25.05";
        };
    };
}
