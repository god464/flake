{ config, lib, ... }:
let
  cfg = config.network'.dae;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.network'.dae.enable = mkEnableOption "dae";
  config = mkIf cfg.enable {
    sops = {
      secrets.sub = {
      };
      templates."config.dae".content = ''
        global {
          tproxy_port: 12345
          tproxy_port_protect: true

          tcp_check_url: 'http://cp.cloudflare.com,1.1.1.1,2606:4700:4700::1111'
          tcp_check_http_method: HEAD
          udp_check_dns: 'dns.google.com:53,8.8.8.8,2001:4860:4860::8888'

          check_interval: 30s
          check_tolerance: 50ms

          wan_interface: auto

          tls_implementation: tls
          utls_imitate: chrome_auto

          log_level: info
          allow_insecure: false
          auto_config_kernel_parameter: false
        }

        dns {
          upstream {
            googledns: 'tcp+udp://dns.google:53'
            alidns: 'udp://dns.alidns.com:53'
          }
          routing {
            request {
              qname(geosite:category-ads) -> reject
              qname(geosite:category-ads-all) -> reject
              fallback: alidns
            }
            response {
              upstream(googledns) -> accept
              ip(geoip:private) && !qname(geosite:cn) -> googledns
              fallback: accept
            }
          }
        }

        subscription {
           my_sub: '${config.sops.placeholder.sub}'
        }

        group {
          proxy {
            policy: min_avg10
          }
        }

        routing {
          pname(NetworkManager) -> direct

          dip(224.0.0.0/3, 'ff00::/8') -> direct
          dip(geoip:private) -> direct
          dip(geoip:cn) -> direct

          l4proto(udp)  && dport(443) -> block

          domain(geosite:cn) -> direct
          domain(geosite:category-scholar-cn) -> direct
          domain(geosite:geolocation-cn) -> direct

          fallback: proxy
        }
      '';
    };
    services.dae = {
      enable = true;
      configFile = "${config.sops.templates."config.dae".path}";
    };
  };
}
