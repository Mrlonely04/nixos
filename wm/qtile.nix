{inputs, qtile-flake, pkgs, qtile-extras-flake, ...}: let
  qtile-extras-flake = pkgs.python3Packages.qtile-extras.overridePythonAttrs {
    src = inputs.qtile-extras-flake.outPath;
    doCheck = false;
    patches = [];
  };
in {
  services.xserver.windowManager.qtile = {
    enable = true;
    package = qtile-flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
    extraPackages = ps: [qtile-extras-flake];
  };
}
