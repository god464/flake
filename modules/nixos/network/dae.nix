{ config, lib, ... }:
let
  cfg = config.network'.dae;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.network'.dae.enable = mkEnableOption "dae";
  config = mkIf cfg.enable {
    sops = {
      secrets.sub = { };
      templates."config.dae".content = ''
        global {
          tproxy_port: 12345
          tproxy_port_protect: true
          tcp_check_url: 'http://cp.cloudflare.com,1.1.1.1,2606:4700:4700::1111'
          tcp_check_http_method: HEAD
          udp_check_dns: '8.8.8.8:53,114.114.114.114:53,2001:4860:4860::8888,1.1.1.1:53'
          check_interval: 30s
          check_tolerance: 50ms
          wan_interface: auto
          tls_implementation: utls
          utls_imitate: chrome_auto
          log_level: info
          allow_insecure: false
          auto_config_kernel_parameter: true
          enable_local_tcp_fast_redirect: true
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
          pure {
            filter: name(keyword: 'ChatGPT解锁')
            policy: min_moving_avg
          }
          proxy {
            filter: !name(keyword: 'ChatGPT解锁')
            policy: min_moving_avg
          }
        }

        routing {
          pname(NetworkManager) -> direct

          dip(224.0.0.0/3, 'ff00::/8', 10.0.0.0/8, 'fd00::/8') -> direct
          dip(geoip:private,geoip:cn) -> direct

          l4proto(udp)  && dport(443) -> block

          domain(geosite:cn, geolocation-cn) -> direct
          domain(geosite:openai, geosite:anthropic) -> pure
          domain(geosite:category-ads-all) -> block

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
