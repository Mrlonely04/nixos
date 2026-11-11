{...}: {
  flake.nixosModules.homelab = {...}: {
    users.users.homelab = {
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = [
        "wheel"
      ];
    };
  };
}
