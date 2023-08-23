{
  services = {
    postgresql = {
      enable = true;
      enableJIT = true;
    };
    postgresqlBackup = {
      enable = true;
      compression = "zstd";
    };
  };
}
