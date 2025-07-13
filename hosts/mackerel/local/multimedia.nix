{ pkgs, config, ... }: {

  users.groups.multimedia = { };
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group = "multimedia";
  };

  services.navidrome = {
    enable = true;
    openFirewall = true;
    group = "multimedia";
    settings = {
      Address = "0.0.0.0";
      PID = {
        Album = "folder";
      };
    };
  };

  services.lidarr = {
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

  services.radarr = {
    enable = true;
    openFirewall = true;
    group = "multimedia";
  };

  services.jackett = {
    enable = true;
    openFirewall = true;
    group = "multimedia";
  };
  
  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
