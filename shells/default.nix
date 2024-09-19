{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          yaml-language-server
          nixfmt-rfc-style
          yamlfmt
        ];
      };
    };
}
