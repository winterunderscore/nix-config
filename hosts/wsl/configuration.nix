# Edit this configuration file to define what should be installed on your system. Help is available in the configuration.nix(5) man page, on 
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository: https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, inputs, ... }:

{ imports = let
    modules = inputs.self.nixosModules;
  in [ 
    
    ./local/packages.nix

    modules.neovim
    modules.tmux
    modules.yazi
  ];   

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = { users = {
      "winter" = import ./home.nix;
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; system.stateVersion = "24.05";
}
