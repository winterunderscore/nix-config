{ pkgs, ... }: {
  # i only have this to run roblox (via sober) on roblox

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.flatpak.enable = true;
}
