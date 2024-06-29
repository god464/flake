{
  hostName = "builder";
  nftables.enable = true;
  firewall = {
    enable = true;
    checkReversePath = "strict";
    filterForward = true;
  };
  networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    enableStrongSwan = true;
  };
}
