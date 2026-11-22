{ config, ... }: {
   home.file.".config/nvim".source = ./config/nvim;
   xdg.configFile."mango" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/solaris/nixos/home/solaris/services/config/mango";
      recursive = true;
   };
}
