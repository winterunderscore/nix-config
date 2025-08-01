{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.nixosModules.stylix ];
  
  stylix.enable = true;
  stylix.image = ../../../files/nixos.png;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.polarity = "dark";
}
