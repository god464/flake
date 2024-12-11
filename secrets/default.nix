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
  };
}
