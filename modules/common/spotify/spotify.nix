{ inputs, pkgs, ... }:
let 
spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
# Enables spotify and spicetify
   programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
         adblockify
         hidePodcasts
         shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      theme = spicePkgs.themes.hazy;
   };
}
