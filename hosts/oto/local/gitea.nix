{ ... }: {
  services.gitea = {
    enable = true;
    settings = {
      server = {
        SSH_PORT = 2222;
        HTTP_PORT = 3001;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 2222 ];
}
