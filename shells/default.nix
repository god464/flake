{
  perSystem =
    { pkgs, ... }:
    {
      devShells = {
        vterm = pkgs.mkShell {
          packages = with pkgs; [
            cmake
            (emacs.override { withPgtk = true; })
            gcc
            gnumake
            libtool
          ];
        };
        lua = pkgs.mkShell {
          packages = with pkgs; [
            lua-language-server
            selene
            stylua
            gcc
            gnumake
            yaml-language-server
            vscode-langservers-extracted
            taplo
          ];
        };
        cc = pkgs.mkShell {
          packages = with pkgs; [
            clang-tools
            lldb
            cmake
            ninja
            clang
            neocmakelsp
          ];
        };
        nix = pkgs.mkShell {
          packages = with pkgs; [
            nixd
            nixfmt-rfc-style
          ];
        };
        rust = pkgs.mkShell {
          packages = with pkgs; [
            rustc
            rustfmt
            clippy
            cargo
            rust-analyzer
          ];
        };
      };
      formatter = pkgs.nixfmt-rfc-style;
    };
}
