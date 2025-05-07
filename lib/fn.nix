{ lib, ... }:
rec {

  importModule' =
    path:
    builtins.readDir path
    |> lib.attrNames
    |> lib.subtractLists [ "default.nix" ]
    |> map (n: path + "/${n}");

}
