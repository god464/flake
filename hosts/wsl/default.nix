{ pkgs, lib, inputs, ... }: {
  wsl = {
    enable = true;
    defaultUser = "cl";
    startMenuLaunchers = true;
  };
  time.timeZone = "Asia/Shanghai";
  i18n.efaultLocale = "en_US.UTF-8";
  nixpkgss.config.allowUnFree = true;
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
  hardware.cpu.amd.updateMicrocode = true;
  networking.hostName = "nixos";
  users = {
    users = {
      cl = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        createHome = true;
        shell = pkgs.zsh;
        initialPassword = "a";
      };
    };
  };
  environment = {
    systemPackages = lib.mkAfter (with pkgs; [ unzip unrar wget vim ]);
  };
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
    users.cl = import ./home.nix;
  };
  system.stateVersion = "23.11";
}
