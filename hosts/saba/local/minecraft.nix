{ inputs, ... }: {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    openFirewall = true;
    servers = {
      koi = {
        enable = true;

        serverProperties = {
          motd = "hi";
          level-seed = "koi";
          online-mode = false;
        };
      };
    };
  };
}
