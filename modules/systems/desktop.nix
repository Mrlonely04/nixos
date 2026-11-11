{ self, inputs, ...}:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      flatpak
      ollama
      mango
      noctalia
      spotify
    ];
  };
}
