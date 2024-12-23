{ pkgs, ... }: {
  home-manager.users.winter.programs = {
    neovim = {
      enable = true;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
