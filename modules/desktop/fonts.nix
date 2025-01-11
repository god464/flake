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
    fonts = {
      packages = with pkgs; [
        fira-code
        sarasa-gothic
        source-han-sans
        source-han-serif
        source-han-mono
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        jigmo
        noto-fonts
        noto-fonts-extra
        source-serif-pro
        source-sans-pro
        nerd-fonts.symbols-only
        twemoji-color-font
        font-awesome
      ];
      fontconfig = {
        subpixel.rgba = "rgb";
        defaultFonts = {
          serif = [
            "Source Han Serif SC"
            "Noto Serif CJK SC"
            "Symbols Nerd Font"
          ];
          sansSerif = [
            "Source Han Sans SC"
            "Noto Sans CJK SC"
            "Symbols Nerd Font"
          ];
          monospace = [
            "Source Han Mono SC"
            "Noto Sans Mono CJK SC"
            "Symbols Nerd Font Mono"
          ];
          emoji = [
            "Twitter Color Emoji"
            "Symbols Nerd Font"
          ];
        };
      };
    };
  };
}
