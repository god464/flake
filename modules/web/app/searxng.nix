{ config, lib, ... }:
let
  cfg = config.web'.app.searxng;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.web'.app.searxng.enable = mkEnableOption "searxng";
  config = mkIf cfg.enable {
    services.searx = {
      enable = true;
      settings = {
        ui = {
          static_use_hash = true;
          center_alignment = true;
          search_on_category_select = false;
          hotkeys = "vim";
        };
        server = {
          port = "8888";
          bind_address = "::1";
          # secret_key = config.sops.secrets.searx.path;
          image_proxy = true;
          method = "GET";
        };
        engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
          "duckduckgo".disabled = true;
          "brave".disabled = true;
          "bing".disabled = false;
          "qwant".disabled = true;
        };
      };
    };
  };
}
