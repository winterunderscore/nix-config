{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:kaylorben/nixcord";
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs: {
    nixosModules = import ./modules;
    
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          nixos-wsl.nixosModules.default
          {
            system.stateVersion = "24.05";
            wsl.enable = true;
            wsl.defaultUser = "winter";
          }
          ./hosts/wsl/configuration.nix
          inputs.home-manager.nixosModules.default
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              inputs.nixcord.homeManagerModules.nixcord
	    ];
	  }
        ];
      };

      laptop1 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/laptop1/configuration.nix
          inputs.home-manager.nixosModules.default
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              inputs.nixcord.homeManagerModules.nixcord
	    ];
	  }
        ];
      };
    };  
  };
}
