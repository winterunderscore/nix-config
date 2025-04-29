{ pkgs, inputs, ... }: {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    openFirewall = true;
    servers = {
      koi = {
        enable = true;
        package = pkgs.vanillaServers.vanilla-1_21_4;

        serverProperties = {
          motd = "lets play idk";
          online-mode = false;
          server-port = 25565;
          level-seed = 8003646019033114113;
        };

      };
      test = {
        enable = false;
        # package = pkgs.fabricServers.fabric-1_21_4;
        package = pkgs.fabricServers.fabric-1_21_1;

        serverProperties = {
          motd = "test server";
          gamemode = 1;
          level-seed = 8003646019033114113;
          online-mode = false;
          server-port = 25566;
        };
        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            # 1.21.4
            # Carpet = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/aVB2lYQQ/fabric-carpet-1.21.4-1.4.161%2Bv241203.jar"; sha512 = "fd42f43ae89af7553ee1b8240efda178a05f5b0f45fe359651cea468cfd11fe24996e991c338522f4a17b07b917e9ebda4a5cfa8551fca280c81e536b240a96c"; };
            # CreativeCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/OsZiaDHq/versions/ixu9AXyq/CreativeCore_FABRIC_v2.12.35_mc1.21.4.jar"; sha512 = "24431c494a91c633fc1099192830e22dba203fa3ba2a309155895c38d22776ddd72021b6fba0c435c538b2f0568ae8ba7571e8041855639c7a76689c0d1c537b"; };

            # 1.21.1
            WATERFrAMES = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/eBzFuVTM/versions/APOfkg2U/waterframes-FABRIC-mc1.21.1-v2.1.12b.jar"; sha512 = "78cd0a8b4f0446b2b9ebf4e24cbd069b486c4f72c62975d1accfa02465f2e44d5e155eda36d8e529e05663f89f583c23115f2bd2b89ee777d15fab096aca2677"; };
            CreativeCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/OsZiaDHq/versions/7CVMkNmO/CreativeCore_FABRIC_v2.13.1_mc1.21.1.jar"; sha512 = "673b18752d1ba1f7548393bdcd3de65dcc8406bdd7f382d6bfbc965b74d2f176ef292c729d05e209affef3ca87e39b256892cf6d67e29b8289876cfa70794749"; };

            # 1.21.1 - 1.21.4
            WATERMeDIA = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/G922NeHS/versions/tdrzHjoW/watermedia-2.1.23.jar"; sha512 = "ad36f9a7bb3ed9406f5efd97184ad76b823477836d9571c7d2e96c8b1e71c81ed7ebce36494321d31495b2e047c81051f10c2f80ed084e986330424d1c198464"; };
          });
        };
      };
    };
  };
  environment.systemPackages = [ pkgs.vlc ]; #required for watermedia and waterframes to work
}
