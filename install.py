#!/usr/bin/env nix-shell
#!nix-shell -p python3 git -i python3

import subprocess
import os

print("Installation of SeTSeR's config.")

subprocess.check_output(["git", "submodule", "update", "--init", "--recursive"])

config = "/mnt/etc/nixos/configuration.nix"

print("Creating ", config)
os.makedirs("/mnt/etc/nixos", exist_ok=True)
open(config, 'w').write('import %s' % os.getcwd())
print("Done")
print("Installing")
subprocess.check_output(["nixos-generate-config", "--root", "/mnt"])
subprocess.check_output(["nixos-install", "--root", "/mnt"])
os.mkdir("/home/smakarov/.config/")
os.symlink("./.config/i3status", "/home/smakarov/.config/i3status")
os.symlink("./.config/nixpkgs", "/home/smakarov/.config/nixpkgs")
print("Done")