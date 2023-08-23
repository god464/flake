{ lib, pkgs, inputs, config, ... }:
{
  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "zh_CN.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_CTYPE = "zh_CN.UTF-8";
    };
  };
  console = {
    useXkbConfig = true; # use xkbOptions in tty.
  };
  nixpkgs.config.allowUnfree = true;
  nix = {
    sshServe.enable = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
  };
  security = {
    polkit.enable = true;
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };
  programs = {
    zsh.enable = true;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
        enableExtraSocket = true;
      };
    };
    vim.defaultEditor = true;
  };
  environment.systemPackages = with pkgs;[
    wget
    age
    sops
    vim
  ];
  system.stateVersion = "23.11";
}
