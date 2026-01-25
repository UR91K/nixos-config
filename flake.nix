{
  description = "A new NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri, ... }@inputs: {
    nixosConfigurations = {
      # Change 'nixos' to your actual hostname
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
