{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter
    ((with pkgs; [ python3Full pyright black ruff virtualenv poetry ])
      ++ (with pkgs.python3Packages; [ debugpy pip pygments ]));
}
