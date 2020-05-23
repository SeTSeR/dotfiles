{ pkgs, config, ... }: {
  programs.zsh.enable = true;
  # Set up the user
  users.users.smakarov = {
    isNormalUser = true;
    home = "/home/smakarov";
    description = "Sergey Makarov";
    extraGroups = [ "wheel" "networkmanager" "video" "storage" ];
    hashedPassword =
    "$6$bhfILKl6NKxZT25$wOQ0A9AtNYLCGLHcR4Bee7VBzYUusq4Af.DAL4Qr5c12JN3LBYH1PFtm.UvCcvXjZ1PbpuhGndnQCgbPaj/.C.";
    shell = pkgs.zsh;
  };

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  home-manager.useUserPackages = true;
  home-manager.users.smakarov = {
    home.sessionVariables = {
      EDITOR = "${pkgs.emacsGit}/bin/emacsclient -c";
      VISUAL = "${pkgs.emacsGit}/bin/emacsclient -c";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      NIX_AUTO_RUN = "1";
      XDG_SESSION_TYPE = "wayland";
      XKB_DEFAULT_LAYOUT = "us,ru(winkeys)";
      XKB_DEFAULT_OPTIONS = "grp:caps_toggle";
    };
    home.keyboard = {
      layout = "us,ru(winkeys)";
      options = [ "grp:caps_toggle" ];
    };
    wayland.windowManager.sway.enable = true;
  };
}
