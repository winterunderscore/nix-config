{ pkgs, ... }: {
  home-manager.users.winter = {
    programs.yazi = {
      enable = true;
      package = pkgs.yazi;
    };
  };
}
