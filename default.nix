{ inputs, ... }: {
  imports = [ ./os ./app ];
  sops = {
    age = {
      generateKey = true;
      keyFile = "/var/lib/key.txt";
    };
    defaultSopsFile = ./secrets/vm.yaml;
    secrets = { passwd.neededForUsers = true; };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ ];
    users.cl = import ./hm;
  };
  system.stateVersion = "24.05";
}
