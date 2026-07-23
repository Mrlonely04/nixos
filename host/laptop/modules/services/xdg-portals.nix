{ config, pkgs, ... }: {
   xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
         xdg-desktop-portal-wlr
         xdg-desktop-portal-gtk
      ];
      config = {
         common = {
            default = ["wlr"];
            "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
            "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
         };
      };
      wlr.settings.screencast = {
         exec_before = "disable_notifications.sh";
         exec_after = "enable_notifications.sh";
         chooser_type = "dmenu";
         chooser_cmd = "${pkgs.rofi}/bin/rofi -dmenu";
         max_fps = "60";
      };
   };
   
}
