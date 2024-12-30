{ pkgs, ... }: let 
  theme = pkgs.fetchurl {
    url = "https://catppuccin.github.io/discord/dist/catppuccin-macchiato.theme.css";
    sha256 = "sha256-TuUkPL1F0p40K9+8o7YQqZ06do9c386gjj/UbOaDOKI=";
  };
in {
  home-manager.users.winter.programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop.enable = true;

    config = {
      disableMinSize = true;
      transparent = true;
      frameless = true;

      enabledThemes = [ "theme.css" ];

      plugins = {
        messageLogger = {
          enable = true;
	  logDeletes = true;
	  collapseDeleted = false;
	  logEdits = true;
	  inlineEdits = true;
	  ignoreSelf = true;
	  deleteStyle = "text";
	};
      };
    };
  };

  home-manager.users.winter.xdg.configFile."vesktop/themes/theme.css".source = theme;
}
