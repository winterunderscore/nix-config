{ pkgs, ... }: let
  hypr_conf = ./hypr;
in {
  xdg.enable = true;

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  xdg.configFile."hypr" = { 
    recursive = true;
    source = "${hypr_conf}";
  };
}
