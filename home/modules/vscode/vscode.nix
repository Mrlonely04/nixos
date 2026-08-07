{ pkgs, ... }:
{
   programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
         jnoortheen.nix-ide
         asvetliakov.vscode-neovim
      ];
   };
}
