# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }: 

{
   imports =
      [ # Include the results of the hardware scan.
         ./hardware-configuration.nix
         ./wm/hyprland.nix
         ./wm/mango.nix
         ./system/services.nix
         ./system/nvidia.nix
         ./system/xdg-portals.nix
      ];
   boot.loader.limine.extraEntries = ''
      /Windows_11
      protocol: efi
      path: uuid(bec649ce-ec48-4022-8407-b616b322d88d):/EFI/Microsoft/Boot/bootmgfw.efi
   '';

## TEST

   boot.kernelPackages = pkgs.linuxPackages_cachyos;


## TEST


   networking.hostName = "nykta"; # Define your hostname.

   time.timeZone = "America/New_York";

   programs.zsh.enable = true;
   users.extraUsers.nykta = {
         shell = pkgs.zsh;
   };
   

#  Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.nykta = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
         tree
      ];
   };
   fonts.packages = with pkgs; [
      nerd-fonts.comic-shanns-mono
   ];

#  You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; import ./packages.nix { inherit pkgs; };
   nix.settings.experimental-features = ["nix-command" "flakes" ];

   system.stateVersion = "25.11"; # Did you read the comment?

}
