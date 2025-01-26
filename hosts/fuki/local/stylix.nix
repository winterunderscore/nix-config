{ inputs, ... }: {
  imports = [ inputs.stylix.nixosModules.stylix ];
  
  stylix.enable = true;
  stylix.image = ../../../files/nixos.png;
  stylix.polarity = "dark";
}
