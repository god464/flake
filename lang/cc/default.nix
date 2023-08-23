{ pkgs, lib, ... }: {
  home.packages =
    lib.mkAfter (with pkgs; [ ninja cmake clang-tools clang lldb ]);
}
