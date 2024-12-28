{ pkgs, ... }: {
  home-manager.users.winter.programs.starship = {
    package = pkgs.starship;
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableTransience = true;
  };

  home-manager.users.winter.programs.fish = {
    package = pkgs.fish;
    enable = true;
  };

  users.defaultUserShell = pkgs.fish;
  users.users.winter.shell = pkgs.fish;
  programs.fish.enable = true;
}
