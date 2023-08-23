{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter
    (with pkgs; [ jdk jdt-language-server checkstyle google-java-format ]);
}
