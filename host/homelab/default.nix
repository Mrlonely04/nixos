{ config, lib, pkgs, inputs, ... }:
{
   imports =
      [ # Include the results of the hardware scan.
         ./hardware-configuration.nix
         ./../../modules/core
      ];

   # Defines devices name
   networking.hostName = "homelab"; # Define your hostname.
   networking.networkmanager.enable = true;

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
   users.users.homelab = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
         tree
      ];
   };

   nix.settings.experimental-features = ["nix-command" "flakes" ];

   system.stateVersion = "25.11"; # Did you read the comment?

}
