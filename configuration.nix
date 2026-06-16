# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
   imports =
      [ # Include the results of the hardware scan.
         ./hardware-configuration.nix
      ];

#  Use the systemd-boot EFI boot loader.
   boot.loader.limine.enable = true;
   boot.loader.limine.extraEntries = ''
      /Windows_11
      protocol: efi
      path: uuid(bec649ce-ec48-4022-8407-b616b322d88d):/EFI/Microsoft/Boot/bootmgfw.efi
   '';
   boot.loader.efi.canTouchEfiVariables = true;
   services.udisks2.enable = true;

   networking.hostName = "nykta"; # Define your hostname.
#  Configure network connections interactively with nmcli or nmtui.
   networking.networkmanager.enable = true;

#  Set your time zone.
   time.timeZone = "America/New_York";
	
   programs.hyprland = {
	   enable = true;
		withUWSM = true;
		xwayland.enable = true;
	};
   services.power-profiles-daemon.enable =true;
   services.displayManager.ly.enable = true;
   nixpkgs.config.allowUnfree = true;
   programs.zsh.enable = true;
   users.extraUsers.nykta = {
         shell = pkgs.zsh;
      };

#   GPU Drivers
  hardware.graphics.enable32Bit = true;
  hardware.graphics.enable = true;
     services.xserver.videoDrivers = ["nvidia"];
        hardware.nvidia = {
           modesetting.enable = true;
           powerManagement.enable = false;
           powerManagement.finegrained = false;
           open = true;
           nvidiaSettings = true;
           package = config.boot.kernelPackages.nvidiaPackages.latest;
         };
   
  services.flatpak.enable = true;


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
