{ lib, ... }:
rec {

  # importModule' =
  #   path:
  #   builtins.readDir path
  #   |> lib.attrNames
  #   |> lib.subtractLists [ "default.nix" ]
  #   |> map (n: path + "/${n}");
  getFileNames = { path, exclude }: lib.subtractLists exclude (lib.attrNames (builtins.readDir path));
  importModule' =
    path:
    map (n: path + "/${n}") (getFileNames {
      inherit path;
      exclude = [ "default.nix" ];
    });
}
