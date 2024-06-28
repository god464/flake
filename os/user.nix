{ pkgs, config, ... }: {
  users = {
    mutableUsers = false;
    users = {
      cl = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        createHome = true;
        shell = pkgs.zsh;
        hashedPasswordFile = config.sops.secrets.passwd.path;
      };
    };
  };
}
