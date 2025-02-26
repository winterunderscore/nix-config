{ pkgs, config, ... }: {

  users.groups.multimedia = { };
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group = "multimedia";
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "multimedia";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];

  /*
   * not worky
   *

  services.rtorrent = {
    enable = true;
    port = 51412;
    openFirewall = true;
  };

  services.flood = {
    enable = true;
    port = 8112;
    openFirewall = true;
    extraArgs = ["--rtsocket=${config.services.rtorrent.rpcSocket}"];
  };

  systemd.services.flood.serviceConfig.SupplementaryGroups = [ config.services.rtorrent.group ];
  */

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
