{ config, pkgs, lib, ... }:
{
  home-manager.users.smakarov.programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; with pkgs.nur.repos.setser.vscode-extensions; [
      kahole.magit
      bbenoist.Nix
      ms-vscode-remote.remote-ssh
      matklad.rust-analyzer
      james-yu.latex-workshop
      WakaTime.vscode-wakatime
    ] ++
    [ # Extensions from NUR
      Rubymaniac.vscode-direnv
      sjhuangx.vscode-scheme
      tuttieee.emacs-mcx
      vscode-org-mode.org-mode
    ];
    keybindings = [
      {
        key = "ctrl-x g";
        command = "magit.status";
      }
      {
        key = "ctrl-x ctrl-c";
        command = "workbench.action.quit";
      }
    ];
    userSettings = {
      "update.mode" = "none";
      "[nix].editor.tabSize" = 2;
      "org.todoKeywords" = [
        "TODO" "NEXT" "DONE" "WAITING" "HOLD" "CANCELLED"
      ];
      "emacs-mcx.strictEmacsMove" = true;
      "workbench.colorTheme" = "Solarized Light";
    };
  };
}
