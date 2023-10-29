{ pkgs, lib, inputs, ... }: {
  wsl = {
    enable = true;
    defaultUser = "nixos";
    startMenuLaunchers = true;
  };
  time.timeZone = "Asia/Shanghai";
  i18n.efaultLocale = "en_US.UTF-8";
  nixpkgss.config.allowUnfree = true;
  nix = {
    sshServe = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weeks";
      options = "--delete-older-than 10d";
    };
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.hostName = "nixos";
  users = {
    users = {
      nixos = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        createHome = true;
        shell = pkgs.zsh;
        initialPassword = "a";
      };
    };
  };
  environment.systemPackages =
    lib.mkAfter (with pkgs; [ unzip unrar wget vim deploy-rs nixos-anywhere ]);
  programs = {
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      enableExtraSocket = true;
    };
    vim.defaultEditor = true;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.nixos = import ./home.nix;
  };
  system.stateVersion = "23.11";
}
