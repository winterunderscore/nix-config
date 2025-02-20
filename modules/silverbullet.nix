{ ... }: {
  services.silverbullet = {
    enable = true;
    openFirewall = true;
    listenAddress = "0.0.0.0";
  };
}
