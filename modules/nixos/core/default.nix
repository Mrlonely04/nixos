{config, ...}:
{
  flake.nixosModules.core.imports = with config.flake.nixosModules; [
    boot
  ];
}
