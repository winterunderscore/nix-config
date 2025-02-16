{ ... }: {
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "${pkgs.hyprland}/bin/Hyprland";
  services.xrdp.openFirewall = true;
}
