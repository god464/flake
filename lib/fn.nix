{ lib, ... }:
rec {
  getFileNames = { path, exclude }: lib.subtractLists exclude (lib.attrNames (builtins.readDir path));

  importModule' =
    path:
    map (n: path + "/${n}") (getFileNames {
      inherit path;
      exclude = [
        "default.nix"
        "secrets.yaml"
        "db.key"
        "db.pem"
        "config.dae"
      ];
    });
}
