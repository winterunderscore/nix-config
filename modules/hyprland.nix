{ pkgs, ... }: {

  services.displayManager.ly.enable = true;
  services.displayManager.sessionPackages = [
    (
      (pkgs.writeTextDir "share/wayland-sessions/hyprland.desktop" ''
        [Desktop Entry]
        Name=hyprland
        Comment=InsertSomeCommentHere
        Exec=${pkgs.hyprland}/bin/Hyprland
        Type=Application
      '')
      .overrideAttrs
      (_: {
        passthru.providedSessions = ["hyprland"];
      })
    )
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ph";
    variant = "";
  };

  programs.hyprland.enable = true;

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
	];
	modules-center = [
          "hyprland/window"
	  "privacy"
	];
	modules-right = [
          "tray"
	  "pulseaudio/slider"
	  "battery"
	  "clock"
	];
	"pulseaudio/slider" = {
          min = 0;
	  max = 100;
	  orientation = "horizontal";
	};
      };
    };
    style = ./waybar/styles.css;
  };
}
