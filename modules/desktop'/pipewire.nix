{
  config,
  lib,
  ...
}:
let
  cfg = config.services.displayManager;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    environment.persistence."/persist".users.cl.directories = [ ".local/state/wireplumber" ];
  };
}
