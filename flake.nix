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


	};
	
	outputs = inputs@{ self, nixpkgs, home-manager, zen-browser, mangowm, chaotic, ... }:
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
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.solaris = import ./home/solaris;
                  home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
               }
            ];
         };

         server = {
            specialArgs = { inherit inputs; };
            inherit system;
            modules = [
               ./host/server
               home-manager.nixosModules.home-manager
               mangowm.nixosModules.mango
               {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.server = import ./home/server;
                  home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
               }
            ];
         };
      };
	};		
}
