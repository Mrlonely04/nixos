{ pkgs, inputs, config, lib, ... }:
{
   boot.kernelPackages = pkgs.linuxPackages_cachyos;
}
