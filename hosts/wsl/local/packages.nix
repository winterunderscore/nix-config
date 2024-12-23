{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    gh

    tree
    ripgrep
    hyperfine
  ];
}
