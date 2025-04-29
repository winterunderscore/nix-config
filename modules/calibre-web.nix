{ ... }: {
  services.calibre-web = {
    enable = true;
    group = "multimedia";
    listen = {
      ip = "0.0.0.0";
      port = 8083;
    };
    options = {
      calibreLibrary = "/var/media/ebook";
      enableBookUploading = true;
      enableBookConversion = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 8083 ];
}
