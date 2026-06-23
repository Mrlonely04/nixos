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
      qtile-flake = {
         url = "github:qtile/qtile";
         inputs.nixpkgs.follows = "nixpkgs";
      };
      qtile-extra-flake = {
         url = "github:elparaguayo/qtile-extras";
         flake = false;
      };


	};
	
	outputs = { self, nixpkgs, home-manager, zen-browser, qtile-flake, ... } @ inputs: {
		nixosConfigurations.nykta = nixpkgs.lib.nixosSystem {
			system = "X86_64-linux";
         specialArgs = {inherit inputs qtile-flake;}; 
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
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
