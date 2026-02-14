{ config, lib, ... }:
let
  cfg = config.web'.search.meilisearch;
  inherit (lib) mkEnableOption;
in
{
  options.web'.search.meilisearch.enable = mkEnableOption "meilisearch";
  config = lib.mkIf cfg.enable { services.meilisearch.enable = true; };
}
