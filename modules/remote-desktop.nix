{...}: {
  home-manager.users.winter.services.remmina = {
    enable = true;
  };

  services.xrdp = {
    enable = true;
    openFirewall = true;
  };
}
