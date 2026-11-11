{...}: {
  flake.nixosModules.nykta = {...}: {
    users.users.nykta = {
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = [
        "wheel"
      ];
    };
  };
}
