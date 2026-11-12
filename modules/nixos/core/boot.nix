{
  flake.nixosModules.boot = {
    boot.loader.limine.extraEntries = ''
       /Windows_11
       protocol: efi
       path: uuid(bec649ce-ec48-4022-8407-b616b322d88d):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
    boot.loader.limine.secureBoot.enable = true;
  };
}
