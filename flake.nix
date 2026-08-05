{
   description = "Nixos from Scratch";
	
	inputs = {
	   nixpkgs.url = "nixpkgs/nixos-unstable";
      #Chaotic pkgs
      chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      #Zen-Browser
      zen-browser.url = "github:0xc000022070/zen-browser-flake";
      #Home-Manager
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
      #Mangowm 
      mangowm.url = "github:mangowm/mango";
      mangowm.inputs.nixpkgs.follows = "nixpkgs";
      #Noctalia
      noctalia.url = "github:noctalia-dev/noctalia/cachix";
      #Spicetify
      spicetify-nix.url = "github:Gerg-L/spicetify-nix";


	};
	
	outputs = inputs@{ self, nixpkgs, home-manager, zen-browser, mangowm, chaotic, spicetify-nix, ... }:
   let
   system = "x86_64-linux";
   in
   {


      # setting up multi system support
      nixosConfigurations = {

         desktop = nixpkgs.lib.nixosSystem  {
            specialArgs = { inherit inputs; };
            inherit system;
            modules = [
               ./host/desktop
               home-manager.nixosModules.home-manager
               mangowm.nixosModules.mango
               chaotic.nixosModules.default
               spicetify-nix.nixosModules.spicetify 
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.nykta = import ./home/nykta;
                  home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
               }
            ];
         };

         laptop = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            inherit system;
            modules = [
               ./host/laptop
               home-manager.nixosModules.home-manager
               mangowm.nixosModules.mango
               spicetify-nix.nixosModules.spicetify 
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.solaris = import ./home/solaris;
                  home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
               }
            ];
         };

         homelab = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            inherit system;
            modules = [
               ./host/homelab
               home-manager.nixosModules.home-manager
               mangowm.nixosModules.mango
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.gomelab = import ./home/homelab;
                  home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
               }
            ];
         };

         steamMachine = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            inherit system;
            modules = [
               ./host/steamMachine
               home-manager.nixosModules.home-manager
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.steamMachine = import ./home/SteamMachine;
                  home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
               }
            ];
         };
      };
	};		
}
