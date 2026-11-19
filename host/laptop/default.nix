{ pkgs, config, ... }:
let
  USER_ID = 1000; # choose any number, doesn't matter
  USER = "solaris"; # whatever your username is
  KEY_FILE = "id_ed25519"; # or whatever key file
in
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
         #./../../modules/common/librewolf

      ];
        users.users.${USER}.uid = USER_ID;
        environment.sessionVariables.SSH_AUTH_SOCK = "/run/user/${toString USER_ID}/ssh-agent";
        programs.ssh.startAgent = true;
        # add ssh key on login
        systemd.user.services.ssh-add-key = {
          wantedBy = [ "default.target" ];
          after = [ "ssh-agent.service" ];
          serviceConfig = {
            Type = "oneshot";
            ExecStartPre = "${pkgs.coreutils-full}/bin/sleep 1";
            ExecStart = [
              "${pkgs.openssh}/bin/ssh-add ${config.users.users.${USER}.home}/.ssh/${KEY_FILE}"
            ];
            Restart = "on-failure";
            RestartSec = 1;
          };
        };

        # your other configs ...


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
   programs.nix-ld = {
     enable = true;
      libraries = [ pkgs.nixd pkgs.nil ];
   };


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
