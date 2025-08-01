{ pkgs, inputs, ... }: {
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    openFirewall = true;
    servers = {
      xynoan = {
        enable = false;
        package = pkgs.vanillaServers.vanilla-1_21_5;
        
        serverProperties = {
          online-mode = false;
          server-port = 25568;
          difficulty = "hard";
        };
      };
      xynoan-test = {
        enable = false;
        package = pkgs.vanillaServers.vanilla-1_21_5;

        serverProperties = {
          online-mode = false;
          server-port = 25569;
          gamemode = 1;
          difficulty = "normal";
        };
      };
      yuki = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_6;
        jvmOpts = "-Xms4G -Xmx6G";

        serverProperties = {
          online-mode = false;
          server-port = 25570;
          difficulty = "hard";
        };
        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            SDLink = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Sh0YauEf/versions/U3TpSJoR/SimpleDiscordLink-Universal-3.3.1.jar"; sha512 = "bca2573b976653539945454e0ebcefcf72d8a4ef4ca008db124c705184cc99de15fb2acdb74cebe92f62611eb01d7611afe19de40b036443a2381d7a8de9560d"; };
            CraterLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Nn8Wasaq/versions/o3hiSSue/CraterLib-Fabric-1.21.6-2.1.5.jar"; sha512 = "b5600ddd724921fd9227e105131f67aca2d7e208e8e8d226ddcc4a3087f5edfced101d72a91dc8560f8af25cffe1e8ee69c123853612e9e987ea1134e7fecc40"; };
            FabricAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/N3z6cNQv/fabric-api-0.127.1%2B1.21.6.jar"; sha512 = "c7b4ea754a486193476b33ac4d1eaeb30b644e05b76a6abe8cf51ca4eb6832063d32293f1c9052c32c806712d26f85b531085a3ff52575021ee831a804167c4d"; };
            SkinRestorer = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/ghrZDhGW/versions/VbBPgHha/skinrestorer-2.3.4%2B1.21.6-fabric.jar"; sha512 = "8c1bb8b70ce1495f02c24db718c1e3665d50a308f9c46dbef62acf5252a6be12911b627149ec8e57efc3937ae2ec66fbe7cda2079b7c40e86349085137f928cc"; };
            Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/XWGBHYcB/lithium-fabric-0.17.0%2Bmc1.21.6.jar"; sha512 = "a8d6a8b69ae2b10dd0cf8f8149260d5bdbd2583147462bad03380014edd857852972b967d97df69728333d8836b1e9db8997712ea26365ddb8a05b8c845c6534"; };
            FerriteCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar"; sha512 = "131b82d1d366f0966435bfcb38c362d604d68ecf30c106d31a6261bfc868ca3a82425bb3faebaa2e5ea17d8eed5c92843810eb2df4790f2f8b1e6c1bdc9b7745"; };
            Carpet = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/NXZ9k9lc/fabric-carpet-1.21.6-1.4.176%2Bv250617.jar"; sha512 = "2d71e3a6453bbbad1c36ac50f1ff0e387ff1f44b53c5ed877c02ff7495b193a3babccb778f59cbf5941a8bdd4331b61972175d57fe19ba21548cbf2fa44fe8b9"; };

            # no 1.21.6 ver
            # CarpetExtra = pkgs.fetchurl { url = "https://github.com/gnembon/carpet-extra/releases/download/1.4.169/carpet-extra-1.21.5-1.4.169.jar"; sha512 = "1g4mz7ly40iahdpk0pcklczw6lfi49cxmwq8jaj30a3g7h1cfj5kb9lkka5q4vvndgn4x2644bhy68z2zdmgap3izbdq7lg2jszcwzp"; };

            CarpetTISAddition = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/jE0SjGuf/versions/HsayMI7r/carpet-tis-addition-v1.67.1-mc1.21.6.jar"; sha512 = "0925a25d02709d38a1a044c01b2adf08eada8c32eeeee19b812f8d8c06494e57c08e65378eb75a961a34064101beb31084b0dc451676216c42da59e089df7433"; };
            AntiShadowPatch = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/a2CiPRW8/versions/iSpATpNi/antishadowpatch-1.21.5-2.1.2.jar"; sha512 = "d5379ebf0d5dd83944e15eeb6932fd48d28e614693d8c13deb1204dab4ad8ba908ad3a8e6edc8345cc221143bf6c538ef714a061fb5d7f25b84dc00453f98615"; };
            FConfigLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/8cuS4dwo/versions/VEwOoOSv/fconfiglib-1.1.1.jar"; sha512 = "a4335a67666490cc3ec24f565a16c463d7bec0e4fa196574352b18b2ef24929592b481f118a85f1db576c1697049a620b78a87e140a7cedcd5d01fb2fe49413f"; };
            # Servux = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/zQhsx8KF/versions/GGj3rNei/servux-fabric-1.21.5-0.6.0.jar"; sha512 = "cb2dddf4a3ca959c9e9507b9b3f3cb1242b616d4c7c81c33680032207b863c61268efa14f3e978ba9ccf0dbb0902623d6ce7194a52f55d906a0e62c4e08c6d3f"; };
            # TradeCycling = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/qpPoAL6m/versions/dirqc2Im/trade-cycling-fabric-1.21.5-1.0.18.jar"; sha512 = "4824658081576790587b1b262ea01c511f0bd0cd2c5dd8d0a57158d3debe3ce5bb07a6caa0e62474efb6e13bbf0157b7fcfc70d23fe3c588c4a01bc718d64b19"; };
            VMP = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/wnEe9KBa/versions/aWatA9pi/vmp-fabric-mc1.21.6-0.2.0%2Bbeta.7.200-all.jar"; sha512 = "185e9ea7f7ded136cd781845a2d422fbdeb6daa04bad605b9f59c001e0b90bad6f2a1ed4ff78bcdabd0bd13f2be09c636783ee4205101f2a919ade9e64bcde98"; };
          });
        };
      };
      koi = {
        enable = false;
        package = pkgs.vanillaServers.vanilla-1_21_4;

        serverProperties = {
          motd = "lets play idk";
          online-mode = false;
          server-port = 25565;
          level-seed = 8003646019033114113;
        };
      };
      koi-test = {
        enable = false;
        package = pkgs.fabricServers.fabric-1_21_4;
        # package = pkgs.fabricServers.fabric-1_21_1;

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
            Carpet = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/aVB2lYQQ/fabric-carpet-1.21.4-1.4.161%2Bv241203.jar"; sha512 = "fd42f43ae89af7553ee1b8240efda178a05f5b0f45fe359651cea468cfd11fe24996e991c338522f4a17b07b917e9ebda4a5cfa8551fca280c81e536b240a96c"; };
            # CreativeCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/OsZiaDHq/versions/ixu9AXyq/CreativeCore_FABRIC_v2.12.35_mc1.21.4.jar"; sha512 = "24431c494a91c633fc1099192830e22dba203fa3ba2a309155895c38d22776ddd72021b6fba0c435c538b2f0568ae8ba7571e8041855639c7a76689c0d1c537b"; };

            # 1.21.1
            #            WATERFrAMES = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/eBzFuVTM/versions/APOfkg2U/waterframes-FABRIC-mc1.21.1-v2.1.12b.jar"; sha512 = "78cd0a8b4f0446b2b9ebf4e24cbd069b486c4f72c62975d1accfa02465f2e44d5e155eda36d8e529e05663f89f583c23115f2bd2b89ee777d15fab096aca2677"; };
            #            CreativeCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/OsZiaDHq/versions/7CVMkNmO/CreativeCore_FABRIC_v2.13.1_mc1.21.1.jar"; sha512 = "673b18752d1ba1f7548393bdcd3de65dcc8406bdd7f382d6bfbc965b74d2f176ef292c729d05e209affef3ca87e39b256892cf6d67e29b8289876cfa70794749"; };
            #
            #            # 1.21.1 - 1.21.4
            #            WATERMeDIA = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/G922NeHS/versions/tdrzHjoW/watermedia-2.1.23.jar"; sha512 = "ad36f9a7bb3ed9406f5efd97184ad76b823477836d9571c7d2e96c8b1e71c81ed7ebce36494321d31495b2e047c81051f10c2f80ed084e986330424d1c198464"; };
            });
        };
      };
      blazing = {
        enable = false;
        package = pkgs.fabricServers.fabric-1_20_1;

        serverProperties = {
          motd = "named by tezs";
          level-seed = 5867390645105841362;
          gamemode = 1;
          online-mode = false;
          server-port = 25567;
        };

        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            SDLink = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Sh0YauEf/versions/B4rrgB1b/SimpleDiscordLink-Universal-3.3.0.jar"; sha512 = "c3232aee23c6bb5ea39ed512c243ab591f73e685ea698c92b5708e760ede7fbd9dd7f414ae8564094f760e61cf607f8d1b1fd58a6c7c933863c56a7621239312"; };
            CraterLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Nn8Wasaq/versions/13HU1vOz/CraterLib-Fabric-1.20-2.1.4.jar"; sha512 = "8dbb84066902afebbb1901e512a6d9f8da7416f06b0af638f8e1bf6661a977c8d88ea22ede5cedd701565cb157e014653978507b7d3a88b3a10c4eb1ae00879a"; };
            VeinMiner = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/OhduvhIc/versions/KTrObKTw/Veinminer-2.0.4.jar"; sha512 = "6e924204246c53ec49f5f1d1a9fdaff7f64d18cbe53cf9cb44f0fb94c99bdcbbcf55bfa6433072895faf4d0800be8236cc5e61bd0dc6ac4a868e06928dee1cc7"; };
            Silk = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/aTaCgKLW/versions/3H0nUJhq/silk-all-1.10.1.jar"; sha512 = "d5e8d8108f5d91ea1a89332e65705482378702dfe23b185a9784b0349df28f429d4af5b8908181bd4820ba89bf6aca9b2687523543daaf6b79c946d4fe7908c0"; };
            Kotlin = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/E4WyjCxJ/fabric-language-kotlin-1.13.2%2Bkotlin.2.1.20.jar"; sha512 = "875c8ea380dce07c8a3dd5249226265745d3fc84876e2f1b235ce99084aa991f7d08c05ab12d73a3209649e3bd4d7c407b96d4b4f4a332179d40afdae836a92f"; };
            Tectonic = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/w19S52ln/tectonic-fabric-1.20.1-2.4.4.jar"; sha512 = "b5078ffa450e152555b106ab46134a29d4aff0cba49405e029b6c500692210f2ea379cccf138ce9d67e4162ebea431beff16a8a6ff46098f194c002a451ec348"; };
            Lithostitched = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/XaDC71GB/versions/fFfu2FPH/lithostitched-fabric-1.20.1-1.4.4.jar"; sha512 = "eba73344cef6f733492a1619e097fb498318f06875fda7e05a2847ef9c039b17d9542087a44636611f569924beb4178576141e61ae6ebc5841e0b3ed6791ed71"; };
            WWOO = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/II7t6llZ/versions/cNiETBJi/WWOO-FABRIC%2BFORGE%2BQUILT-2.0.0.jar"; sha512 = "745acab6cb1634ccceacce523fd09e58b5d5a8fafe8e186384cbd23233e3ce4c8e2e214d4252240a9a59b56a668c15414e133f71e83f719bec8bd89aad4747da"; };

            # Needs Client-side
            Create = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Xbc0uyRg/versions/7Ub71nPb/create-fabric-0.5.1-j-build.1631%2Bmc1.20.1.jar"; sha512 = "73ff936492c857ae411c10cae0194d64a56b98a1a7a9478ca13fe2a6e3ee155e327cf4590a3888aaa671561b4cf74de97f2f44224d7981b03a546e36236c3de2"; };
            ImmersiveAircraft = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/x3HZvrj6/versions/LM56MFWP/immersive_aircraft-1.2.2%2B1.20.1-fabric.jar"; sha512 = "a20948695b2cefb4aac94fae75cdb7fc1552afa22607400c268d02feea4a76dc6278f267e3f63fc84177f069ee68d89256ca6cd17593677f35f6cdd9d7a8af34"; };
            # Gravestones = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/ssUbhMkL/versions/Uw9uAQaY/gravestones-v1.15.jar"; sha512 = "d15c6db9d9154464f335f01ae7f8ce8d2473251ed5a6c094a2f6e59ba778de6dfdefd7ee6a08d5908b826e37028de8edc3745a7af19ee00b59971f33bdfee2c5"; };
            EMI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fRiHVvU7/versions/VvPw7Vi5/emi-1.1.22%2B1.20.1%2Bfabric.jar"; sha512 = "6781a72c54af058b72601edea102d9eaf6ff4f8ee5d0ede72cc86b7a79a961fd7c0cc55486938d679d7303c21f95c242ca01b3e9b3be56a41bb3dd11ab766a03"; };
            JEI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/u6dRKJwZ/versions/KcsHvRrB/jei-1.20.1-fabric-15.20.0.106.jar"; sha512 = "c84f58f186c16c47799b46a603b30b352b4cf45b210de59c347c6c974f2886de04593a77c08794b52c409d279b42d6d0e0667e88eeb97550f3963f64dfc2abf7"; };
            FabricAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/PB9Kjpo3/fabric-api-0.92.5%2B1.20.1.jar"; sha512 = "e42bf30f4c60d7e3b07579b3ecc1aed345dc76dd72633514c9df6e801e9753a582abe7d722797a0045d46ea860029bf138a301ec30397eb151a0611cea1069e7"; };
            KnightQuest = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VEOQ4Jz4/versions/fRlukK2W/knightquest-fabric-1.20.1-1.8.5.jar"; sha512 = "b135f7d34212fd7650809cfdc1e46106f2760407516359174376af1620577daf0c2a81e62e4806a6d62b1380a93c921329082fd2da8e1785c51b112d85904dd9"; };
            GeckoLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/8BmcQJ2H/versions/ytGMpRks/geckolib-fabric-1.20.1-4.7.1.2.jar"; sha512 = "6c4fd60cfce9b398e7fe71946e4847cf9c5f509148a7f9f5352fdb844803c72631f7b13645f7358607fa5dc4fd3a7d8c620a22499cb7c51b5718a6d460a0c78f"; };
            KnightLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/hAnl9nbm/versions/X1WxKH9c/knightlib-fabric-1.20.1-1.2.0.jar"; sha512 = "e1379a5e0b6b7dcdb6dd11dc6aba0e57a6a725a7799e4eab24f85926dcd97e05c1bc4d94a9fe489b0486c91df12c99783405fe465b98c341af83c9aeaad4a760"; };
            Botania = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/pfjLUfGv/versions/t7kGxx07/Botania-1.20.1-448-FABRIC.jar"; sha512 = "d0e03933d1eca7de855d5cb0ce09a240ff36fe26754b2e901000524b0543bfef959c31ca5bb6f35bd7a01c718ea44c01e1a734317f56ae67166434986034019d"; };
            Trinkets = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/5aaWibi9/versions/AHxQGtuC/trinkets-3.7.2.jar"; sha512 = "bedf97c87c5e556416410267108ad358b32806448be24ef8ae1a79ac63b78b48b9c851c00c845b8aedfc7805601385420716b9e65326fdab21340e8ba3cc4274"; };
            Patchouli = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/nU0bVIaL/versions/Muu5nGmj/Patchouli-1.20.1-84.1-FABRIC.jar"; sha512 = "a08ae7db9381bf44ff5a22e5fa0cc44ff744fe220df6c88863eded09274786609e8705dc6a31f70c072127c81255a413d37aa479dd2aaf07bc7ed0c822e0a070"; };
          });
        };
      };
    };
  };
  environment.systemPackages = [ pkgs.vlc ]; #required for watermedia and waterframes to work
}
