{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter (with pkgs; [ yamllint yaml-language-server ]);
}
