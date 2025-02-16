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

#  home-manager.users.winter.home.pointerCursor = {
#    x11.enable = true;
#    gtk.enable = true;
#    package = pkgs.oreo-cursors-plus;
#    name = "oreo_spark_violet_bordered_cursors";
#    size = 20;
#  };
  home-manager.users.winter.home.sessionVariables.GSK_RENDERER = "gl";

  home-manager.users.winter.services.mako = {
    enable = true;
  };

  home-manager.users.winter.services.hyprpaper = {
    enable = true;
#    settings = {
#      ipc = "on";
#      splash = false;
#      splash_offset = 2.0;
#
#      preload = [ (builtins.toString ../files/cat.png) ];
#
#      wallpaper = [
#        ("LVDS-1, " + builtins.toString ../files/cat.png)
#      ];
#    };
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
        exec-once = wayvnc

        exec-once = [workspace special:obsidian silent] obsidian
        exec-once = [workspace special:discord silent] vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime
        exec-once = [workspace 2 silent] firefox
      '';
      env = ''
        env = XCURSOR_SIZE,24
        env = HYPRCURSOR_SIZE,24
        env = XDG_CURRENT_DESKTOP,Hyprland
        env = XDG_SESSION_DESKTOP,Hyprland
        env = XDG_SESSION_TYPE,wayland
      '';
      window_rules = ''
        windowrulev2 = suppressevent maximize, class:.*
        windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
        
        windowrulev2 = workspace special:discord silent, class:(vesktop)
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
        }

      '';

      input = ''
        windowrule = pseudo, fcitx
        exec-once=fcitx5 -d -r --enable-all
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
        bind = $mainMod, S, togglespecialworkspace, obsidian
        bind = $mainMod, D, togglespecialworkspace, discord
        bind = $mainMod, A, togglespecialworkspace, magic
        bind = $mainMod SHIFT, A, movetoworkspace, special:magic
        
        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1
        
        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

	# audio
	bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
	bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

#        # flameshot
#        bind = $mainMod, H, exec, flameshot gui

        # hyprshot
        bind = $mainMod, PRINT, exec, hyprshot -m window --clipboard-only --freeze
        bind = , PRINT, exec, hyprshot -m output --clipboard-only --freeze
        bind = $shiftMod, PRINT, exec, hyprshot -m region --clipboard-only --freeze
      '';

     
    in ''
      ${display}
      ${program_conf}
      ${exec}
      ${window_rules}
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
	  "pulseaudio"
          "backlight"
	  "battery"
	  "clock"
          "tray"
	];

        "clock" = {
          format = " {:%H:%M・%Y年%m月%d日}";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            default = [ "" "" ];
          };
        };
        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [ "" "" ];
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };
      };
    };
#    style = let
#      colorscheme = ''
#        /*
#        *
#        * Catppuccin Mocha palette
#        * Maintainer: rubyowo
#        *
#        */
#
#        @define-color base   #1e1e2e;
#        @define-color mantle #181825;
#        @define-color crust  #11111b;
#
#        @define-color text     #cdd6f4;
#        @define-color subtext0 #a6adc8;
#        @define-color subtext1 #bac2de;
#
#        @define-color surface0 #313244;
#        @define-color surface1 #45475a;
#        @define-color surface2 #585b70;
#
#        @define-color overlay0 #6c7086;
#        @define-color overlay1 #7f849c;
#        @define-color overlay2 #9399b2;
#
#        @define-color blue      #89b4fa;
#        @define-color lavender  #b4befe;
#        @define-color sapphire  #74c7ec;
#        @define-color sky       #89dceb;
#        @define-color teal      #94e2d5;
#        @define-color green     #a6e3a1;
#        @define-color yellow    #f9e2af;
#        @define-color peach     #fab387;
#        @define-color maroon    #eba0ac;
#        @define-color red       #f38ba8;
#        @define-color mauve     #cba6f7;
#        @define-color pink      #f5c2e7;
#        @define-color flamingo  #f2cdcd;
#        @define-color rosewater #f5e0dc;
#      '';
#      styles = ''
#        /*
#        * taken and mixed together from: 
#        * - https://github.com/rubyowo/dotfiles/blob/f925cf8e3461420a21b6dc8b8ad1190107b0cc56/config/waybar/style.css &
#        * - https://github.com/hatosu/nix-config/blob/main/module/hyprland.nix
#        * thanks twin (rubyowo) and hatosu ^^
#        */
#
#        * {
#          font-family: "JetBrainsMono Nerd Font";
#          font-size: 11px;
#          border-radius: 5px;
#          font-weight: bold;
#          min-height: 11px;
#        }
#
#        #waybar {
#          background: transparent;
#          color: @text;
#          margin: 5px 5px;
#        }
#
#        #workspaces {
#          border-radius: 7px;
#          margin: 5px;
#          background-color: @surface0;
#          margin-left: 0rem;
#        }
#
#        #workspaces button {
#          color: @lavender;
#          box-shadow: none;
#          text-shadow: none;
#          padding: 0px;
#          border-radius: 9px;
#          margin-top: 3px;
#          margin-bottom: 3px;
#          margin-left: 0px;
#          padding-left: 3px;
#          padding-right: 3px;
#          margin-right: 0px;
#          animation: ws_normal 20s ease-in-out 1;
#        }
#
#        #workspaces button.active {
#          background-color: @overlay0;
#          color: @sky;
#          margin-left: 3px;
#          padding-left: 12px;
#          padding-right: 12px;
#          margin-right: 3px;
#          animation: ws_active 20s ease-in-out 1;
#          transition: all 0.4s cubic-bezier(.55,-0.68,.48,1.682);
#        }
#
#        #workspaces button:hover {
#          background-color: @overlay1;
#          color: @sapphire;
#          border-radius: 9px;
#          animation: ws_hover 20s ease-in-out 1;
#          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
#        }
#
#        #tray,
#        #backlight,
#        #clock,
#        #battery,
#        #pulseaudio {
#          background-color: @surface0;
#          border-radius: 0px 0px 0px 0px;
#          margin-left: 0px;
#          padding-left: 6px;
#          padding-right: 6px;
#          margin-right: 0px;
#        }
#
#        #tray {
#          border-radius: 5px;
#          margin-left: 3px;
#          margin-right: 3px;
#        }
#
#        #pulseaudio {
#          border-radius: 5px 0px 0px 5px;
#          color: @maroon;
#          margin-left: 3px;
#          padding-left: 12px;
#        }
#
#        #clock {
#          border-radius: 0px 5px 5px 0px;
#          color: @blue;
#          margin-right: 3px;
#          padding-right: 12px;
#        }
#
#        #battery {
#          color: @green;
#        }
#
#        #backlight {
#          color: @yellow;
#        }
#
#      '';
#    in builtins.toFile "styles.css" ''
#      ${colorscheme}
#      ${styles}
#    '';
    
  };

  environment.systemPackages = with pkgs; [
    rofi-wayland
    hyprshot
    hyprpaper
    hyprsunset
    hyprutils
    wl-clipboard
    wayvnc

    mako
  ]; 
}
