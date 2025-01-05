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
    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      set fish_greeting
      if test "$SHLVL" -lt 3
        ufetch
      end
    '';
  };

  users.defaultUserShell = pkgs.fish;
  users.users.winter.shell = pkgs.fish;
  programs.fish.enable = true;

  home-manager.users.winter.programs = {
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    bat = {
      enable = true;
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      colors = "always";
    };
    thefuck = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    gh
    
    tree
    fzf
    ripgrep
    hyperfine
    tokei

    any-nix-shell
  ] ++ (with pkgs.fishPlugins; [
    fzf-fish
  ]);
}
