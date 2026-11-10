{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.network'.mihomo;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.network'.mihomo.enable = mkEnableOption "mihomo";
  config = mkIf cfg.enable {
    sops = {
      secrets = {
        subscription = { };
        controller = { };
      };
      templates."mihomo.yaml" = {
        content = lib.generators.toYAML { } {
          "mixed-port" = 7890;
          "allow-lan" = false;
          mode = "rule";
          "log-level" = "info";
          ipv6 = true;
          "external-controller" = "127.0.0.1:9090";
          secret = config.sops.placeholder.controller;
          profile = {
            "store-selected" = true;
            "store-fake-ip" = true;
          };
          tun = {
            enable = true;
            stack = "mixed";
            "auto-route" = true;
            "auto-detect-interface" = true;
            "strict-route" = true;
            "dns-hijack" = [
              "any:53"
              "tcp://any:53"
            ];
          };
          dns = {
            enable = true;
            listen = "127.0.0.1:1053";
            ipv6 = true;
            "enhanced-mode" = "fake-ip";
            "fake-ip-range" = "198.18.0.1/16";
            "default-nameserver" = [
              "1.1.1.1"
              "8.8.8.8"
            ];
            "proxy-server-nameserver" = [ " https://1.1.1.1/dns-query" ];
            nameserver = [
              "https://1.1.1.1/dns-query"
              "https://8.8.8.8/dns-query"
            ];
            "fake-ip-filter" = [
              "localhost"
              "*.local"
              "*.lan"
            ];
          };
          "proxy-providers".airport = {
            type = "http";
            url = config.sops.placeholder.subscription;
            path = "./providers/airport.yaml";
            interval = 86400;
            "health-check" = {
              enable = true;
              url = "https://www.gstatic.com/generate_204";
              interval = 300;
            };
            "proxy-groups" = [
              {
                name = "PROXY";
                type = "select";
                use = [ "airport" ];
                proxies = [
                  "AUTO"
                  "DIRECT"
                ];
              }
              {
                name = "AUTO";
                type = "url-test";
                use = [ "airport" ];
                interval = 300;
                tolerance = 50;
              }
            ];
            rules = [
              "DOMAIN-SUFFIX,cn,DIRECT"
              "GEOIP,CN,DIRECT"
              "DOMAIN,localhost,DIRECT"
              "MATCH,PROXY"
            ];
          };
        };
        mode = "0400";
      };
    };
    services.mihomo = {
      enable = true;
      tunMode = true;
      webui = pkgs.metacubexd;
      configFile = config.sops.templates."mihomo.yaml".path;
    };
  };
}
