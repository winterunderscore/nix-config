# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, inputs, config, pkgs, ... }:

{
  imports = let
    modules = inputs.self.nixosModules;
  in [
      ./local/powermanagement.nix
      ./local/packages.nix
      ./local/stylix.nix

      modules.nvf
      modules.cli

      modules.yazi
      modules.bitwarden
      modules.fastfetch
      modules.harsh
      modules.tmux

      modules.cc
      modules.rust

      modules.tailscale
      modules.silverbullet
      modules.syncthing
      modules.kavita
      ./local/homepage.nix
      ./local/minecraft.nix
      ./local/bots.nix
      ./local/sops.nix
      ./local/gitea.nix
      ./local/multimedia.nix
      ./local/qbittorrent.nix

      ./local/graphics.nix
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mackerel"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  services.logind.lidSwitchExternalPower = "ignore";
  systemd.sleep.extraConfig = ''
    AllowSuspend=no 
    AllowHibernation=no 
    AllowHybridSleep=no 
    AllowSuspendThenHibernate=no
    '';

  # Set your time zone.
  time.timeZone = "Asia/Manila";
  networking.timeServers = [ "0.asia.pool.ntp.org" ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  users.users.winter = {
    isNormalUser = true;
    description = "winter";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nix.settings.substituters = ["https://hyprland.cachix.org"];
  nix.settings.trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ "winter" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  home-manager = { 
    backupFileExtension = "backup";
  users = {
    "winter" = import ./home.nix;
  }; };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
