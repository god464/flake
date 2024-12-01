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
      fira-code-nerdfont
      sarasa-gothic
      source-han-sans
      source-han-serif
      noto-fonts
      noto-fonts-extra
      nerd-fonts.symbols-only
      twemoji-color-font
      noto-fonts-color-emoji
    ];
  };
}
