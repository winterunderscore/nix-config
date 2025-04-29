{ config, pkgs, ... }: let
  port = 5000;
in {
  services.kavita = {
    enable = true;
#    tokenKeyFile = pkgs.writeText "token-that-anyone-can-see-at-my-github" "CQtZ0aJMKBe0cMdfPNEGqIfsc408VekbkNpO3xjGXjP+xCtxKzRaLTKrQXZJSgKDH/wVmODLhi+ru4zpD4o2IA==";
    tokenKeyFile = config.sops.secrets.kavita_token.path;
    settings = {
      Port = port;
    };
  };
  networking.firewall.allowedTCPPorts = [ port ];
  users.users.kavita.extraGroups = [ "multimedia" ];
}
