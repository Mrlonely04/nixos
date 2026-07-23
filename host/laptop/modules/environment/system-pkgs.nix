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
         xdg-desktop-portal-wlr
         pavucontrol
         wget
         zsh
         oh-my-zsh
         rose-pine-hyprcursor
         wl-clipboard
         brightnessctl
         power-profiles-daemon
      ];
   };
}
