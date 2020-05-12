{ config, lib, ... }: {
  imports = [
    ./alacritty.nix
    ./emacs
    ./firefox.nix
    ./git.nix
    ./gnupg.nix
    ./sway
    ./mail.nix
    ./openvpn.nix
    ./packages.nix
    ./services.nix
    ./smakarov.nix
    ./ssh.nix
    ./vim.nix
    ./xresources.nix
    ./zsh.nix
  ];
}
