{
  flake.nixosModules.boot = {
    boot.loader = {
       limine.enable = true;
       efi.canTouchEfiVariables = true;
    };
  };
}
