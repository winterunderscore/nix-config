/*
https://nixos.wiki/wiki/Nvidia
https://nixos.wiki/wiki/Laptop#Hybrid_graphics
*/

{ config, pkgs, ... }:
{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  nixpkgs.config.nvidia.acceptLicense = true;
  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_390;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
