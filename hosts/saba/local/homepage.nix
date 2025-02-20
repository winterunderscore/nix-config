{ ... }: {
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
              href = "http://saba:8096/";
            };
          }
          {
            "qBittorrent" = {
              description = "technically-not-multimedia but torrenting client";
              href = "http://saba:58080/";
            };
          }
        ];
      }
      {
        "Productivity" = [
          {
            "SilverBullet" = {
              description = "note-taking";
              href = "http://saba:3000";
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
