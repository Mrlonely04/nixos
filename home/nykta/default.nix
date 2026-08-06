{ config, pkgs, inputs, system, ... }: 
{
   imports = [
      ./../modules/obs
      ./../modules/git
      ./services
   ];

   # Basic user info
   home.username = "nykta";
   home.stateVersion = "25.11";

   programs.home-manager.enable = true;

   #shell configuration
   programs.zsh = {
      enable = true;
      enableCompletion = true;
		shellAliases = {
         update = "nix flake update";
			rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#desktop";
         clean = "nix-collect-garbage -d";
         Sclean = "sudo nix-collect-garbage -d";
         list-gen = "nixos-rebuild list-generations";
		};
		profileExtra = ''
			if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTR" = 1 ]; then
			exec uwsm start -S hyprland-uwsm.desktop
			fi
		'';
      oh-my-zsh = {
         enable = true;
         plugins = [
            "git"         # also requires `programs.git.enable = true;`
         ];
         theme = "robbyrussell";
      };
      
   };

   # Packages that will come with the user
   home.packages = with pkgs; [
      git
      tree
      htop
      inputs.zen-browser.packages."${system}".twilight
      vesktop
      protonplus
      heroic
   ];
}
