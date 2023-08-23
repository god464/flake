{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter
    ((with pkgs; [ luajit stylua lua-language-server ])
      ++ (with pkgs.luajitPackages; [ luacheck ]));
}
