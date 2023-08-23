{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter (with pkgs; [ perl perlnavigator ]);
}
