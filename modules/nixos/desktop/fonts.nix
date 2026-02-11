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
        apple-sf-pro
        apple-sf-mono
        apple-new-york
        sarasa-gothic
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts
        source-han-sans
        source-han-serif
        source-han-mono
        nerd-fonts.symbols-only
        twemoji-color-font
        noto-fonts-color-emoji
        maple-mono.Normal-CN
      ];
      fontconfig = {
        subpixel.rgba = "rgb";
        defaultFonts = {
          serif = [
            "Source Han Serif SC"
            "Noto Serif CJK SC"
            "Symbols Nerd Font"
            "Twitter Color Emoji"
          ];
          sansSerif = [
            "Source Han Sans SC"
            "Noto Sans CJK SC"
            "Symbols Nerd Font"
            "Twitter Color Emoji"
          ];
          monospace = [
            "Source Han Mono SC"
            "Noto Sans Mono CJK SC"
            "Maple Mono Normal CN"
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
