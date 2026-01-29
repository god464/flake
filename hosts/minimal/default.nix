{
  imports = [ ./disk.nix ];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };
  networking = {
    hostName = "minimal";
    nftables.enable = true;
    firewall = {
      checkReversePath = "strict";
      filterForward = true;
    };
    useNetworkd = true;
    enableIPv6 = true;
  };
  services.resolved = {
    enable = true;
    settings = {
      DNSOverTLS = true;
      DNSSEC = true;
    };
  };
  users.users.root.initialPassword = "a";
}
