{ config, lib, pkgs, inputs, ... }:
{
   imports =
      [ # Include the results of the hardware scan.
         ./hardware-configuration.nix
         ./../../modules/core
         ./../../modules/common/flatpak
         ./../../modules/common/gaming
         ./../../modules/common/spotify
         ./../../modules/common/mango
      ];

   # Adds windows to boot options
   boot.loader.limine.extraEntries = ''
      /Windows_11
      protocol: efi
      path: uuid(bec649ce-ec48-4022-8407-b616b322d88d):/EFI/Microsoft/Boot/bootmgfw.efi
   '';


   # Defines devices name
   networking.hostName = "nykta"; # Define your hostname.
   networking.networkmanager.enable = true;

   # Time zone obv
   time.timeZone = "America/New_York";

   # allows unfree pkgs
   nixpkgs.config.allowUnfree = true;

   # Font
   fonts.packages = with pkgs; [
      nerd-fonts.comic-shanns-mono
   ];

   # Enables and caches nocatalia
   environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
   ];
   nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
   };
   
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
