{ config, pkgs, ... }: let 
  hostname = "mackerel";
in {
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    environmentFile = "${pkgs.writeText "env" ''
HOMEPAGE_ALLOWED_HOSTS=*
      ''}";
    settings = {
      theme = "dark";
      color = "slate";
      headerStyle = "underlined";
    };
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
              href = "http://${hostname}:8096";
              widget = {
                type = "jellyfin";
                url = "http://${hostname}:8096";
                key = "e68d1db0ae8e43b8b34b150193c70e66";
              };
            };
          }
          {
            "qBittorrent" = {
              href = "http://${hostname}:${builtins.toString config.services.qbittorrent.port}";
              widget = {
                type = "qbittorrent";
                url = "http://${hostname}:${builtins.toString config.services.qbittorrent.port}";
                username = "winter";
                password = "suikazura";
              };
            };
          }
          {
            "Kavita" = {
              href = "http://${hostname}:${builtins.toString config.services.kavita.settings.Port}";
              widget = {
                type = "kavita";
                url = "http://${hostname}:${builtins.toString config.services.kavita.settings.Port}";
                username = "winter";
                password = "suikazura";
              };
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
