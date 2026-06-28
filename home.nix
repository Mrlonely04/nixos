{ config, pkgs, system, inputs, ... }:
{
    imports = [
    ];
# User
   home.username = "nykta";
	home.homeDirectory = "/home/nykta";
	home.stateVersion = "25.11";

# Git
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

# ZSH
	programs.zsh = {
		enable = true;
      enableCompletion = true;
		shellAliases = {
			up = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nykta";
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

# OBS STUDIO
   programs.obs-studio = {
      enable = true;
      package = (
         pkgs.obs-studio.override {
            cudaSupport = true;
         }
      );
      plugins = with pkgs.obs-studio-plugins; [
         obs-backgroundremoval
         obs-pipewire-audio-capture
      ];
   };


	
   home.file.".config/foot".source = ./config/foot;
   home.file.".config/waybar".source = ./config/waybar;
   home.file.".config/nvim".source = ./config/nvim;
   home.file.".config/mako".source = ./config/mako;
   xdg.configFile."mango" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nykta/nixos-dotfiles/config/mango";
      recursive = true;
   };
   xdg.configFile."hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/nykta/nixos-dotfiles/config/hypr";
      recursive = true;
   };
   home.packages = with pkgs; [
      inputs.zen-browser.packages."${system}".twilight
   ];
}
