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
      nerd-fonts.fira-code
      sarasa-gothic
      source-han-sans
      source-han-serif
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk
      nerd-fonts.symbols-only
      twemoji-color-font
    ];
  };
}
