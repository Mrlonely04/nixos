{ pkgs, ... }:
{
   
   environment.systemPackages = with pkgs; [
      kitty
      thunar
      wlr-randr
      fastfetch
      pipewire
      wireplumber
      rofi
      neovim
      xdg-desktop-portal-wlr
      wget
      wl-clipboard
   ];

}
