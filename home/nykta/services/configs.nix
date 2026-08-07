{ config, ... }: {
   home.file.".config/foot".source = ./config/foot;
   home.file.".config/waybar".source = ./config/waybar;
   home.file.".config/nvim".source = ./config/nvim;
   home.file.".config/mako".source = ./config/mako;
   xdg.configFile."mango" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nykta/nixos/home/nykta/services/config/mango";
      recursive = true;
   };
   xdg.configFile."hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nykta/nixos/home/nykta/services/config/hypr";
      recursive = true;
   };

}
