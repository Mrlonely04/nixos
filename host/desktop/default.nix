{ pkgs, config, ... }:
let
  USER_ID = 1000; # choose any number, doesn't matter
  USER = "nykta"; # whatever your username is
  KEY_FILE = "id_ed25519"; # or whatever key file
in
{
   imports =
      [ # Include the results of the hardware scan.
         ./hardware-configuration.nix
         ./../../modules/core
         ./../../modules/common/flatpak
         ./../../modules/common/gaming
         ./../../modules/common/spotify
         ./../../modules/common/mango
         ./../../modules/common/noctalia
         ./../../modules/common/waydroid
         #./../../modules/common/vm
         ./../../modules/common/ollama

      ];
      #users.users.${USER}.uid = USER_ID;
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

   # Adds windows to boot options
   boot.loader.limine.extraEntries = ''
      /Windows_11
      protocol: efi
      path: uuid(bec649ce-ec48-4022-8407-b616b322d88d):/EFI/Microsoft/Boot/bootmgfw.efi
   '';
   boot.loader.limine.secureBoot.enable = true;

   # Defines devices name
   networking.hostName = "nykta"; # Define your hostname.
   networking.networkmanager.enable = true;

   # Time zone obv
   time.timeZone = "America/New_York";

   programs.nix-ld = {
     enable = true;
      libraries = [ pkgs.nixd pkgs.nil ];
   };
   # allows unfree pkgs
   nixpkgs.config.allowUnfree = true;

   # Font
   fonts.packages = with pkgs; [
      nerd-fonts.comic-shanns-mono
   ];

   # Enables and caches nocatalia
   #environment.systemPackages = [
   #   inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
   #];
   #nix.settings = {
   #   extra-substituters = [ "https://noctalia.cachix.org" ];
   #   extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
   #};

   programs.zsh.enable = true;
   users.defaultUserShell = pkgs.zsh;

   # Sets user
   users.users.nykta = {
    uid = USER_ID;
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
   };
   environment.systemPackages = with pkgs; [
      nixd
      nil
   ];

   nix.settings.experimental-features = ["nix-command" "flakes" ];

   system.stateVersion = "25.11"; # Did you read the comment?

}
