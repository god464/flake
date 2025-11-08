{ lib, osConfig, ... }:
let
  cfg = osConfig.programs.fish;
in
{
  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        ls = "eza";
        cd = "z";
        cat = "bat";
        diff = "batdiff";
        less = "batpipe";
        rg = "batgrep";
        man = "batman";
      };
      shellInit = ''
        set -x GOOGLE_CLOUD_PROJECT "$(cat ${osConfig.sops.secrets.google-code-id.path})"
      '';
    };
  };
}
