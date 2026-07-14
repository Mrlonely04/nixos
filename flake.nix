{
   description = "Nixos from Scratch";
	
	inputs = {
	   nixpkgs.url = "nixpkgs/nixos-unstable";
      #Zen-Browser
      zen-browser.url = "github:0xc000022070/zen-browser-flake";
      #Home-Manager
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
      #Mangowm 
      mangowm.url = "github:mangowm/mango/0.14.4";
      mangowm.inputs.nixpkgs.follows = "nixpkgs";
      #Noctalia
      noctalia.url = "github:noctalia-dev/noctalia/cachix";
      noctalia.inputs.nixpkgs.follows = "nixpkgs";


	};
	
	outputs = inputs@{ self, nixpkgs, home-manager, zen-browser, mangowm, ... }: {
		nixosConfigurations.nykta = nixpkgs.lib.nixosSystem {
			system = "X86_64-linux";
         specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
            mangowm.nixosModules.mango
            ./wm/noctalia.nix
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.nykta = import ./home.nix;
						backupFileExtension = "backup";
                  extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
					};
				}

         
			];
		};
	};		
}
