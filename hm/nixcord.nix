{ pkgs, ... }: {
  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop.enable = true;

    config = {
      disableMinSize = true;
      transparent = true;
      frameless = true;

      enabledThemes = [ "macchiato.theme.css" ];

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

  xdg.configFile."vesktop/themes".source = "${./nixcord/themes}";
}
