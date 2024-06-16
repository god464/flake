{ inputs, config,... }: {
  imports = [ ./os ./app ];
  sops = {
    age = {
      keyFile = "/var/lib/key.txt";
      generateKey = true;
    };
    defaultSopsFile = ./secrets/vm.yaml;
    secrets = {
      passwd.neededForUsers = true;
      wgkey = { 
	owner=config.users.users."systemd-network".name;
	mode="400";
      };
    };
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ ];
    users.cl = import ./hm;
  };
  system.stateVersion = "24.05";
}
