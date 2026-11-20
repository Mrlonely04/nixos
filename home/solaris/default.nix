{ inputs, pkgs, ... }:
{
  imports = [
    inputs.lazyvim.homeManagerModules.default
    ./../modules/git
    ./../modules/zed
    ./../modules/librewolf
    ./services
  ];
  programs.lazyvim = {
    enable = true;
    extras = {
      lang.nix.enable = true;
      lang.python.enable = true;
    };

      # IMPORTANT: Extras don't install treesitter parsers automatically
      # You must add them manually for syntax highlighting
    treesitterParsers = with pkgs.tree-sitter-grammars; [
      tree-sitter-nix
      tree-sitter-python
    ];
  };

  # Basic user info
  home.username = "solaris";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  #shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
		shellAliases = {
      update = "nix flake update";
			rebuild = "sudo nixos-rebuild switch --flake ~/nixos#laptop";
      clean = "nix-collect-garbage -d";
      Sclean = "sudo nix-collect-garbage -d";
      list-gen = "nixos-rebuild list-generations";
		};
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
    vesktop
    proton-vpn
  ];
}
