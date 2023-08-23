{ pkgs, lib, inputs, ... }: {
  imports = [ ../../system/coreServer.nix ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        editor = false;
      };
    };
    initrd = {
      availableKernelModules =
        [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
      supportedFilesystems = [ "btrfs" "ntfs" "exfat" ];
    };
  };
  disko.devices = import ./disko-config.nix;
  networking = {
    hostName = "nixos";
    nftables.enable = true;
    useNetworkd = true;
    firewall = {
      enable = true;
      filterForward = true;
    };
  };
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
    systemPackages = lib.mkAfter (with pkgs; [ sbctl unzip unrar wireshark ]);
  };
  services = {
    resolved.enable = true;
    openssh = {
      enable = true;
      startWhenNeeded = true;
    };
    btrfs.autoScrub.enable = true;
    networkd-dispatcher.enable = true;
  };
  systemd.network.wait-online.enable = lib.mkForce false;
  virtualisation = {
    docker.enable = true;
    vmware.guest.enable = true;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.cl = import ./home.nix;
  };
}
