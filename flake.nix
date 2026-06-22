{
   description = "Nixos from Scratch";
	
	inputs = {
	   nixpkgs.url = "nixpkgs/nixos-unstable";
         zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
            };
         };
      home-manager = {
		   url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
      mangowm = {
         url = "github:mangowm/mango";
         inputs.nixpkgs.follows = "nixpkgs";
      };


	};
	
	outputs = { self, nixpkgs, home-manager, zen-browser, mangowm, ... } @ inputs: {
		nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
			system = "X86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
            mangowm.nixosModules.mango
            
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
