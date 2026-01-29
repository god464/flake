{
  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      http3 = true;
      ipv6_servers = true;
      require_dnssec = true;
      sources = {
        public-resolvers = {
          urls = [ "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md" ];
          cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
        relays = {
          urls = [ "https://download.dnscrypt.info/resolvers-list/v3/relays.md" ];
          cache_file = "/var/cache/dnscrypt-proxy/relays.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };
      };
      server_names = [
        "cloudflare"
        "dnspod"
        "quad9-dnscrypt-ip4-filter-pri"
        "alidns-doh"
      ];
    };
  };
}
