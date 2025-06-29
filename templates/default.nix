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
    in
    {
      rust = mkTemplate { p = "rust"; };
      cc = mkTemplate {
        p = "cc";
        q = "c/c++";
      };
      web = mkTemplate { p = "web"; };
      java = mkTemplate { p = "java"; };
      go = mkTemplate { p = "go"; };
    };
}
