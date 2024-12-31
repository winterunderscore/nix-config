{ lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    scrcpy
    wireshark
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
