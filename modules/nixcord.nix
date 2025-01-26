{ pkgs, ... }: let 
#  theme = pkgs.fetchurl {
#    url = "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css";
#    sha256 = "sha256-0TnWkE/ndOYufghl0+aiMy68twozVoAaTbOF9dD6224=";
#  };
in {
  home-manager.users.winter.programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop.enable = true;

    config = {
      disableMinSize = true;
      transparent = true;
      frameless = true;

#      enabledThemes = [ "theme.css" ];

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
    userPlugins = {
      messageLoggerEnhanced = "github:Syncxv/vc-message-logger-enhanced/199b24e32503c7d3288c5237ed0786d6ce10c855";
    };

    extraConfig = {
      plugins = {
        messageLoggerEnhanced.enable = true;
      };
    };
  };
#  home-manager.users.winter.xdg.configFile."vesktop/themes/theme.css".source = theme;
}
