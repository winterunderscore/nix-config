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

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
    ];
  };

  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

  home-manager.users.winter.home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.oreo-cursors-plus;
    name = "oreo_spark_violet_bordered_cursors";
    size = 20;
  };
  home-manager.users.winter.home.sessionVariables.GSK_RENDERER = "gl";

  home-manager.users.winter.services.mako = {
    enable = true;
  };

  home-manager.users.winter.services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "~/nix/files/cat.png" ];

      wallpaper = [
        "LVDS-1, ~/nix/files/cat.png"
      ];
    };
  };

  programs.hyprland.enable = true;
  home-manager.users.winter.wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
    };
    
    extraConfig = let 
      display = ''
        monitor = ,preferred,auto,auto
      '';
      program_conf = ''
        # See https://wiki.hyprland.org/Configuring/Keywords/
        $terminal = kitty
	$fileManager = thunar
	$menu = rofi -show drun
      '';
      exec = ''
	exec-once = hyprsunset
	exec-once = hyprpaper
        exec-once = waybar
      '';
      env = ''
        env = XCURSOR_SIZE,24
        env = HYPRCURSOR_SIZE,24
        env = XDG_CURRENT_DESKTOP,Hyprland
        env = XDG_SESSION_DESKTOP,Hyprland
        env = XDG_SESSION_TYPE,wayland
      '';
      windowRules = ''
        windowrulev2 = suppressevent maximize, class:.*
        windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
        
        windowrulev2 = opacity 0.90 0.90 floating:0
        windowrulev2 = opacity 0.90 0.90 floating:1
      '';
      visual = ''
        general {
            gaps_in = 9
            gaps_out = 11
        
            border_size = 1
        
            # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
            col.active_border = rgba(f78f88d9) rgba(f5c0bcd9) rgba(ceeaf0d9)
            col.inactive_border = rgba(595959aa)
            # Set to true enable resizing windows by clicking and dragging on borders and gaps
            resize_on_border = false
        
            # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
            allow_tearing = false
        
            layout = dwindle
        }
        decoration {
            rounding = 0
        
            # Change transparency of focused and unfocused windows
            active_opacity = 1.0
            inactive_opacity = 1.0
        
            shadow {
                enabled = true
                range = 4
                render_power = 3
                color = rgba(1a1a1aee)
            }
        
            # https://wiki.hyprland.org/Configuring/Variables/#blur
            blur {
                enabled = true
                size = 3
                passes = 1
        
                vibrancy = 0.1696
            }
        }
        animations {
            enabled = true
        
            # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        
            bezier = easeOutQuint,0.23,1,0.32,1
            bezier = easeInOutCubic,0.65,0.05,0.36,1
            bezier = linear,0,0,1,1
            bezier = almostLinear,0.5,0.5,0.75,1.0
            bezier = quick,0.15,0,0.1,1
        
            animation = global, 1, 10, default
            animation = border, 1, 5.39, easeOutQuint
            animation = windows, 1, 4.79, easeOutQuint
            animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
            animation = windowsOut, 1, 1.49, linear, popin 87%
            animation = fadeIn, 1, 1.73, almostLinear
            animation = fadeOut, 1, 1.46, almostLinear
            animation = fade, 1, 3.03, quick
            animation = layers, 1, 3.81, easeOutQuint
            animation = layersIn, 1, 4, easeOutQuint, fade
            animation = layersOut, 1, 1.5, linear, fade
            animation = fadeLayersIn, 1, 1.79, almostLinear
            animation = fadeLayersOut, 1, 1.39, almostLinear
            animation = workspaces, 1, 1.94, almostLinear, fade
            animation = workspacesIn, 1, 1.21, almostLinear, fade
            animation = workspacesOut, 1, 1.94, almostLinear, fade
        }
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        dwindle {
            pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true # You probably want this
        }
      '';

      other = ''
        master {
            new_status = master
        }
               
        # https://wiki.hyprland.org/Configuring/Variables/#misc
        misc {
            force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = true # If true disables the random hyprland logo / anime girl background. :(
            disable_hyprland_qtutils_check = true
        }

      '';

      input = ''
        windowrule = pseudo, fcitx
        exec-once=fcitx5 -d -r
        exec-once=fcitx5-remote -r
      '';

      binds = ''
        $mainMod = SUPER # Sets "Windows" key as main modifier
        
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, Q, exec, $terminal
        bind = $mainMod, C, killactive,
        bind = $mainMod, M, exit,
        bind = $mainMod, E, exec, $fileManager
        bind = $mainMod, V, togglefloating,
        bind = $mainMod, R, exec, $menu
        bind = $mainMod, P, pseudo, # dwindle
        bind = $mainMod, J, togglesplit, # dwindle
        
        # Move focus with mainMod + arrow keys
        bind = $mainMod, left, movefocus, l
        bind = $mainMod, right, movefocus, r
        bind = $mainMod, up, movefocus, u
        bind = $mainMod, down, movefocus, d
        
        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10
        
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10
        
        # Example special workspace (scratchpad)
        bind = $mainMod, S, togglespecialworkspace, magic
        bind = $mainMod SHIFT, S, movetoworkspace, special:magic
        
        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1
        
        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

	# audio
	bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
	bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

        # hyprshot
        bind = $mainMod, PRINT, exec, hyprshot -m window --clipboard-only --freeze
        bind = , PRINT, exec, hyprshot -m output --clipboard-only --freeze
        bind = $shiftMod, PRINT, exec, hyprshot -m region --clipboard-only --freeze
      '';

     
    in ''
      ${display}
      ${program_conf}
      ${exec}
      ${windowRules}
      ${visual}
      ${other}
      ${input}
      ${binds}
    '';

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

  environment.systemPackages = with pkgs; [
    rofi-wayland
    hyprshot
    hyprpaper
    hyprsunset

    mako
  ]; 
}
