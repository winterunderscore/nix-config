{ pkgs, ...}: {
  environment.systemPackages = [ pkgs.harsh ];

  environment.shellAliases = {
    h = "harsh";
    he = "$EDITOR ~/.config/harsh/habits";
    hl = "$EDITOR ~/.config/harsh/log";
  };
}
