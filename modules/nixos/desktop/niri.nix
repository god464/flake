{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.desktop'.niri;
in
{
  imports = with inputs; [
    niri-flake.nixosModules.niri
    dankMaterialShell.nixosModules.greeter
  ];
  options.desktop'.niri.enable = mkEnableOption "niri";
  config = mkIf cfg.enable {
    programs = {
      niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      dankMaterialShell.greeter = {
        enable = true;
        compositor.name = "niri";
      };
    };
    services.gnome.sushi.enable = true;
    security.pam.services.hyprlock.fprintAuth = false;
    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
      nautilus
      loupe
      gemini-cli
      qwen-code
    ];
  };
}
