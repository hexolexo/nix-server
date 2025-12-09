{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = {
    self,
    nixpkgs,
    deploy-rs,
  }: {
    nixosConfigurations.myserver = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [./configuration.nix];
    };

    deploy.nodes.myserver = {
      hostname = "myserver.example.com";
      remoteBuild = true;
      profiles.system = {
        user = "root";
        path =
          deploy-rs.lib.x86_64-linux.activate.nixos
          self.nixosConfigurations.myserver;
      };
    };

    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = [deploy-rs.packages.x86_64-linux.default];
    };
  };
}
