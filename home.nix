{ config, pkgs, system, inputs, ... }:
{
   home.username = "nykta";
	home.homeDirectory = "/home/nykta";
	home.stateVersion = "25.11";
	programs.git = {
      enable = true;
      settings = {
         user = {  
            name = "Mrlonely04";
            email = "gearlock60@fastmail.com";
         };
         init.defaultBranch = "main";
      };
   };
	programs.zsh = {
		enable = true;
      enableCompletion = true;
		shellAliases = {
			up = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
         clean = "nix-collect-garbage -d";
         Sclean = "sudo nix-collect-garbage -d";
         list-gen = "nixos-rebuild list-generations";
         add-hc = "git add -f /home/nykta/nixos-dotfiles/hardware-configuration.nix";
         rm-hc = "git rm --cached hardware-configuration.nix";
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
      programs.obs-studio = {
         enable = true;
         plugins = with pkgs.obs-studio-plugins; [
            obs-backgroundremoval
            obs-pipewire-audio-capture
         ];
      };

	

	
   home.file.".config/hypr".source = ./config/hypr;
   home.file.".config/foot".source = ./config/foot;
   home.file.".config/waybar".source = ./config/waybar;
   home.file.".config/nvim".source = ./config/nvim;
   home.packages = with pkgs; [
      inputs.zen-browser.packages."${system}".twilight
   ];
}
