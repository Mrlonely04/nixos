{ pkgs, ... }:
{
   config = {
      environment.systemPackages = with pkgs; [
         kitty
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
         rose-pine-hyprcursor
         wl-clipboard
         brightnessctl
         power-profiles-daemon
         upower
      ];
   };
}
