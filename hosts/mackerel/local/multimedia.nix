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

  services.jackett = {
    enable = true;
    openFirewall = true;
    group = "multimedia";
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
