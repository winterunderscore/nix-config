{ pkgs, ... }: {
  home-manager.users.winter.programs = {
    kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      settings = {
        cursor_trail = 3;
	cursor_trail_decay = "0.1 0.4";
      };
    };
  };
}
