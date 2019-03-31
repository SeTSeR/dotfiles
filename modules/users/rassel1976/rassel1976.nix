{ pkgs, config, lib, ... }:
{
  # Set up the user
  users.users.rassel1976 = if config.deviceSpecific.isWorkMachine then {
    isNormalUser = true;
    home = "/home/rassel1976";
    description = "Nikita Golovanov";
    extraGroups = [ "networkmanager" ];
    password = "";
  } else lib.mkForce {};
}
