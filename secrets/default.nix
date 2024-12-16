{
  sops.secrets = {
    db-key = {
      format = "binary";
      sopsFile = ./db.key;
    };
    db-pem = {
      format = "binary";
      sopsFile = ./db.pem;
    };
    host-desktop = {
      format = "binary";
      sopsFile = ./host-desktop.key;
    };
  };
}
