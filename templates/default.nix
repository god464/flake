{
  templates =
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
      rust = mkTemplate "rust";
      cc = mkTemplate "cc" "c/c++";
      web = mkTemplate "web";
      java = mkTemplate "java";
    };
}
