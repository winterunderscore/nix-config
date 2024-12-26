{ pkgs, ... }: {
  home-manager.users.winter.programs = {
    kitty = {
      enable = true;
      themeFile = "Catppuccin-Macchiato";
    };
  };
}
