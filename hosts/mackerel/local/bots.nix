{ pkgs, ... }: {
  systemd.services.kozinteki = {
    enable = true;
    description = "kozinteki discord bot";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.nodejs_23}/bin/node index.js";
      WorkingDirectory = "/home/winter/bots/kozinteki";
      StandardOutput = "inherit";
      StandardError = "inherit";
      Restart = "always";
      User = "winter";
    };
  };
}
