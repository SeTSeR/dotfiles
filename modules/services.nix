{ config, pkgs, lib, ... }: {
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  services.dbus = {
    enable = true;
    socketActivated = true;
  };
  systemd.coredump = {
    extraConfig = "Storage=journal";
  };
  security.pam.loginLimits = [{
    domain = "smakarov";
    type = "soft";
    item = "core";
    value = 1024;
  }];

  sound.enable = true;

  services.udisks2.enable = true;

  services.fstrim.enable = true;
}
