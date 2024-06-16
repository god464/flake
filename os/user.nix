{ pkgs, config, ... }: {
  users = {
    mutableUsers = false;
    users = {
      cl = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        createHome = true;
        shell = pkgs.zsh;
        hashedPasswordFile = config.sops.secrets.passwd.path;
        packages = with pkgs; [ emacs ];
      };
    };
  };
}
