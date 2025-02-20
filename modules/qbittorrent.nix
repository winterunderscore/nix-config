{ ... }: {
  imports = [ ./qbittorrent-service.nix ];
  
  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    port = 58080;
  };
}
