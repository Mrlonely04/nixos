{ pkgs, ... }:
{
   config = {
      environment.systemPackages = with pkgs; [
         kitty
         vesktop
         thunar
         eww
         wlr-randr
         fastfetch
         pipewire
         wireplumber
         rofi
         neovim
         obs-studio
         steam
         protonplus
         heroic
         xdg-desktop-portal-wlr
         pavucontrol
         wget
         zsh
         oh-my-zsh
         rose-pine-hyprcursor
         wl-clipboard
      ];
   };
}
