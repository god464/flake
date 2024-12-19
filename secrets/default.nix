{
  sops.secrets =
    let
      mkSecret = x: {
        format = "binary";
        sopsFile = x;
      };
    in
    {
      db-key = mkSecret ./db.key;
      db-pem = mkSecret ./db.pem;
      host-desktop = mkSecret ./host-desktop.key;
      host-server = mkSecret ./host-server.key;
    };
}
