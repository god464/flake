/*
  let
    cfg = config.desktop'.cosmic;
    inherit (lib) mkEnableOption mkIf mkAfter;
  in
*/
{
  /*
    imports = [ inputs.nixos-cosmic.nixosModules.default ];
    options.desktop'.cosmic = {
      enable = mkEnableOption "cosmic";
    };
    config = mkIf cfg.enable {
      services = {
        desktopManager.cosmic.enable = true;
        displayManager.cosmic-greeter.enable = true;
      };
      environment = {
        systemPackages = mkAfter [ pkgs.wl-clipboard ];
        sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
      };
    };
  */
}
