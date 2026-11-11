{self, inputs, ...}:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      nykta
      flatpak
      ollama
      mango
      noctalia
      spotify
    ];
  };
}
