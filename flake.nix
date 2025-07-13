{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:kaylorben/nixcord";
    stylix.url = "github:danth/stylix";
    hosts.url = "github:StevenBlack/hosts";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager, 
    nixos-wsl, 
    stylix,
    hosts,
    ... 
  } @ inputs: let 
    strings = import ./strings.nix;
    specialArgs = { inherit inputs strings; };
  in {

    nixosModules = import ./modules;
    nixosConfigurations = {
      fuki = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/fuki/configuration.nix
          inputs.home-manager.nixosModules.default
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              inputs.nixcord.homeManagerModules.nixcord
	      inputs.nixvim.homeManagerModules.nixvim
	    ];
	  }
          hosts.nixosModule
          {
            networking.stevenBlackHosts.enable = true;
            networking.stevenBlackHosts = {
              blockFakenews = true;
              blockGambling = true;
            };
          }
        ];
      };
      mackerel = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/mackerel/configuration.nix
          inputs.home-manager.nixosModules.default
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	  }
        ];
      };
    };  
  };
}
