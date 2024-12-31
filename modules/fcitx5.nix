{ pkgs, ... }: {
  environment.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        catppuccin-fcitx5
        fcitx5-mozc-ut
        fcitx5-gtk
      ];
    };
  };
}
