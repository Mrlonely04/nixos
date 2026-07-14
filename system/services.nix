{ config, lib, pkgs, ... }:
{
   #Enables Bluetooth
   hardware.bluetooth.enable = true;

   #Enables Wifi
   networking.networkmanager.enable = true;

   #Display Manager
   services.displayManager.ly.enable = true;

   #Allows Downloads of apps like Discord and so on
   nixpkgs.config.allowUnfree = true;

   #Allows Downloads of Flatpaks
   services.flatpak.enable = true;

   #Enables limine Boot Loader
   boot.loader.limine.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;
   

   #laptop services
   services.upower.enable = true;
   services.power-profiles-daemon.enable = true;

}
