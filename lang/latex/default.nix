{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter (with pkgs; [
    texlive.combined.scheme-full
    gnuplot
    inkscape
    texlab
    tectonic
  ]);
}
