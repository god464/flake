{ config, lib, ... }:
let
  cfg = config.web'.search.meilisearch;
  inherit (lib) mkEnableOption;
in
{
  options.web'.search.meilisearch.enable = mkEnableOption "meilisearch";
  config = lib.mkIf cfg.enable {
    sops.secrets.master_key = { };
    services.meilisearch = {
      enable = true;
      masterKeyFile = config.sops.secrets.master_key.path;
    };
  };
}
