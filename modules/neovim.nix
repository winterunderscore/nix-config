{ pkgs, ... }: {
  home-manager.users.winter.programs = {
    nixvim = {
      enable = true;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      opts = {
        relativenumber = true;
	number = true;
      };

      performance = {
        combinePlugins = {
          enable = true;
	};
	byteCompileLua.enable = true;
      };

      plugins = {
        nix.enable = true;
	treesitter.enable = true;
	presence-nvim.enable = true;
      };

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "macchiato";
        };
      };
    };
  };
}
