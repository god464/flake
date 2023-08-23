{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter
    ((with pkgs; [ deno nodejs yarn typescript prefetch-npm-deps ])
      ++ (with pkgs.nodePackages; [
        bash-language-server
        prettier
        pnpm
        eslint
      ]));
}
