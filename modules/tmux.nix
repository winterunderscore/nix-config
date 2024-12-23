{ pkgs, ... }: {
  home-manager.users.winter.programs.tmux = {
    package = pkgs.tmux;

    enable = true;
  };
}
