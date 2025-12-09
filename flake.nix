{
  inputs = {
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = {
    self,
    nixpkgs,
    deploy-rs,
    nix-minecraft,
  }: {
    nixosConfigurations.vault = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [./configuration.nix];
    };

    deploy.nodes.vault = {
      hostname = "server";
      remoteBuild = true;
      profiles.system = {
        user = "root";
        sshUser = "root";
        path =
          deploy-rs.lib.x86_64-linux.activate.nixos
          self.nixosConfigurations.vault;
      };
    };

    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = [deploy-rs.packages.x86_64-linux.default];
    };
  };
}
