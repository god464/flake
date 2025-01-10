{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.displayManager;
  inherit (lib) mkIf;
in
{
  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      fira-code
      sarasa-gothic
      source-han-sans
      source-han-serif
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      jigmo
      noto-fonts
      noto-fonts-extra
      source-serif-pro
      source-sans-pro
      nerd-fonts.symbols-only
      twemoji-color-font
    ];
  };
}
