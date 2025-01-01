{ pkgs, ... }: {
  home-manager.users.winter.programs.mpv = {
    enable = true;
    config = {
      ytdl-format = "bestvideo+bestaudio";
      osc = "no";
      sub-auto = "no";
      term-status-msg = "no";
      image-display-duration = "inf";
      loop-file = "inf";
      loop-playlist = "inf";
      window-dragging = "no";
    };
    scripts = with pkgs.mpvScripts; [
      mpv-discord
    ];
  };
}
