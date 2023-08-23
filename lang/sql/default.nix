{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter (with pkgs;
    [
      sqlfluff
      # (pkgs.callPackage ../../pkgs/sql-language-server { })
    ]);
}
