{ config, lib, pkgs, ...}:
{
   hardware.graphics.enable32Bit = true;
   hardware.graphics.enable = true;
      services.xserver.videoDrivers = ["nviidia"];
         hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            open = true;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.latest;
         };

}
