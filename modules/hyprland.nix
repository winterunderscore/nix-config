{ pkgs, ... }: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ph";
    variant = "";
  };

  programs.hyprland.enable = true;
  programs.waybar.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
    ];
  };

  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home-manager.users.winter.programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        output = ["*"];
	layer = "top";
	position = "top";
	margin = "5px";
	height = 32;
	modules-left = [
          "hyprland/workspaces"
	  "hyprland/language"
	];
	modules-center = [
          "hyprland/window"
	  "privacy"
	];
	modules-right = [
          "tray"
	  "cpu"
	  "temperature"
	  "memory"
	  "disk"
	  "battery"
	  "clock"
	];
      };
    };
    style = ./waybar/styles.css;
  };
}
