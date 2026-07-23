{ config, lib, pkgs, ... }: 

{
   imports =
      [ # Include the results of the hardware scan.
         ./hardware-configuration.nix
         ./modules
      ];

   # Adds windows to boot options
   boot.loader.limine.extraEntries = ''
      /Windows_11
      protocol: efi
      path: uuid(bec649ce-ec48-4022-8407-b616b322d88d):/EFI/Microsoft/Boot/bootmgfw.efi
   '';

   # Declares cachyos as kernal
   boot.kernelPackages = pkgs.linuxPackages_cachyos;

   # Defines devices name
   networking.hostName = "nykta"; # Define your hostname.

   # Time zone obv
   time.timeZone = "America/New_York";

   # allows unfree pkgs
   nixpkgs.config.allowUnfree = true;

   # Font
   fonts.packages = with pkgs; [
      nerd-fonts.comic-shanns-mono
   ];

   programs.zsh.enable = true;
   users.defaultUserShell = pkgs.zsh;
   # Sets user
   users.users.nykta = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
         tree
      ];
   };
   

   nix.settings.experimental-features = ["nix-command" "flakes" ];

   system.stateVersion = "25.11"; # Did you read the comment?

}
