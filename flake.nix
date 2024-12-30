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

    nixcord.url = "github:kaylorben/nixcord";
  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager, 
    nixos-wsl, 
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
        ];
      };
    };  
  };
}
