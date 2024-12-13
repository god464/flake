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
    host-rsa = {
      format = "binary";
      sopsFile = ./rsa.key;
    };
    host-ed25519 = {
      format = "binary";
      sopsFile = ./ed25519.key;
    };
    host-ecdsa = {
      format = "binary";
      sopsFile = ./ecdsa.key;
    };
  };
}
