{config, lib, pkgs, ...}:
{
   wayland.windowManager.sway = {
      xwayland.enable = true;
      withUWSM = true;
      wrapperFeature.gtk = true;
      package = pkgs.swayfx;
      checkConfig = false;
      extraConfig = ''
         shadows enable
         corner_radius 11
         blur_radius 7
         blur_passes 2
      '';
   };
}
