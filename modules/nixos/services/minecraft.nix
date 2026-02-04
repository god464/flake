{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.services'.minecraft;
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  options.services'.minecraft.enable = mkEnableOption "minecraft";
  config = mkIf cfg.enable {
    services.minecraft-servers = {
      enable = true;
      openFirewall = true;
      eula = true;
      servers.neoforge = {
        enable = true;
        package = pkgs.neoforgeServers.neoforge-1_20_4;
        serverProperties = {
          player-idle-timeout = 60;
          online-mode = false;
          motd = "巧克力与香子兰";
        };
        symlinks.mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            "Mekanism" = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ce6I4WUE/versions/uxe1WQp4/Mekanism-1.20.1-10.4.16.80.jar";
              sha256 = "sha256-Ow0ZH6SkXmYvlyWZHXajAZLzAYarsrppS4c7X3uTWNI=";
            };
            "Mekanism Generators" = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/OFVYKsAk/versions/s68xuFXt/MekanismGenerators-1.20.4-10.5.20.41.jar";
              sha256 = "sha256-XG/XNJ/ec3VEo9trHtKsHpt2jlyEmsYLdWVc+CPPvzA=";
            };
            "Mekanism Tools" = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/tqQpq1lt/versions/zRTNgQSx/MekanismTools-1.20.4-10.5.20.41.jar";
              sha256 = "sha256-KDpWrs6/0L3uZ+fIwAapegx8suGSrQNgVa7UXg0O+/I=";
            };
            "Mekanism Additions" = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/a6F3uASn/versions/ZAaxdWJp/MekanismAdditions-1.20.4-10.5.20.41.jar";
              sha256 = "sha256-vsS0yyGMXcopxGdbkEoIjvDDxZGqWI7v0aPVacnlHck=";
            };
            "Applied Energistics 2" = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/XxWD5pD3/versions/OK01nNQM/appliedenergistics2-neoforge-17.13.0-beta.jar";
              sha256 = "sha256-eYIGIbWMlCkT1b32V8nN/sECV8/VIDqsI4GreXaViOc=";
            };
            "Just Enough Items" = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/u6dRKJwZ/versions/ae5o0o24/jei-1.20.4-neoforge-17.3.1.5.jar";
              sha256 = "sha256-urXOJybA2Z2IlaFmTXOmE8RwDssgjXuR4Cw+eJjAO7I=";
            };
            "JourneyMap" = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/lfHFW1mp/versions/9nnNCz4Y/journeymap-1.20.4-5.10.0-neoforge.jar";
              sha256 = "sha256-PUFVUGTOKuM5sn5sIEDR4zyqpygOjV/HA7Wu+FoigCQ=";
            };
          }
        );
      };
    };
  };
}
