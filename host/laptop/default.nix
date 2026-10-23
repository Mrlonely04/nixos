{ pkgs, ... }:
{
   imports =
      [ # Include the results of the hardware scan.
         ./hardware-configuration.nix
         ./../../modules/core
         ./../../modules/common/laptop
         ./../../modules/common/spotify
         ./../../modules/common/mango
         ./../../modules/common/noctalia
         ./../../modules/common/tailscale
         ./../../modules/common/flatpak
         ./../../modules/common/librewolf

      ];

   # Defines devices name
   networking.hostName = "solaris";
   networking.networkmanager.enable = true;

   # Time zone obv
   time.timeZone = "America/New_York";

   # allows unfree pkgs
   nixpkgs.config.allowUnfree = true;

   # Font
   fonts.packages = with pkgs; [
      nerd-fonts.comic-shanns-mono
   ];

   # Enables and sets zsh as default shell
   programs.zsh.enable = true;

   users.defaultUserShell = pkgs.zsh;
     environment.systemPackages = with pkgs; [
      nixd
      nil
   ];



   # Enables battery checker
   services.upower.enable = true;

   # Enables power profile
   services.power-profiles-daemon.enable = true;

   # Sets user
   users.users.solaris = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
         tree
      ];
   };

   nix.settings.experimental-features = ["nix-command" "flakes" ];

   system.stateVersion = "25.11"; # Did you read the comment?

}
