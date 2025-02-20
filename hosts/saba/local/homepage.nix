{ config, ... }: let 
  hostname = "saba";
in {
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    widgets = [
      {
        resources = {
          cpu = true;
          memory = true;
          disk = "/";
          cputemp = true;
          tempmin = "0";
          tempmax = "100";
          uptime = true;
          units = "metric";
          network = true;
        };
      }
    ];
    services = [
      {
        "Multimedia" = [
          {
            "Jellyfin" = {
              description = "media server";
              href = "http://${hostname}:8096/";
            };
          }
          {
            "qBittorrent" = {
              description = "technically-not-multimedia but torrenting client";
              href = "http://${hostname}:${builtins.toString config.services.qbittorrent.port}/";
            };
          }
        ];
      }
      {
        "Productivity" = [
          {
            "SilverBullet" = {
              description = "note-taking";
              href = "http://${hostname}:${builtins.toString config.services.silverbullet.listenPort}/";
            };
          }
        ];
      }
    ];
    bookmarks = [
      {
        Japanese = [
          {
            TheMoeWay = [
              {
                abbr = "TMW";
                href = "https://learnjapanese.moe/";
              }
            ];
          }
        ];
      }
      {
        Documentation = [
          {
            "NixOS Packages Search" = [
              {
                abbr = "NP";
                href = "https://search.nixos.org/packages";
              }
            ];
          }
          {
            "NixOS Options Search" = [
              {
                abbr = "NO";
                href = "https://search.nixos.org/options";
              }
            ];
          }
        ];
      }
    ];
  };
}
