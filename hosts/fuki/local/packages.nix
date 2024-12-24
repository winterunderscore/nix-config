{ lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    gh

    tree
    ripgrep
    hyperfine

    rofi-wayland
    hyprshot
    hyprpaper
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    font-awesome
  ];
}
