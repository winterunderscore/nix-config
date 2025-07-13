{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.clang ];
}
