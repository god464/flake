{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter (with pkgs; [ bashdb shfmt shellcheck bats ]);
}
