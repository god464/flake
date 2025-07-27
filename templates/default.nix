{ lib, ... }:
{
  flake.templates =
    let
      mkTemplate =
        {
          p,
          q ? p,
        }:
        {
          path = ./src/${p};
          description = "${q} development environment";
        };

      templates = {
        rust = { };
        cc.q = "c/c++";
        web = { };
        java = { };
        go = { };
        haskell = { };
      };
    in
    lib.mapAttrs (name: cfg: mkTemplate ({ p = name; } // cfg)) templates;
}
