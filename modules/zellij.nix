{ ... }: {
  home-manager.users.winter.programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      pane_frames = false;
    };
  };
}
