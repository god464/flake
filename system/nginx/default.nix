{
  services.nginx = {
    enable = true;
    recommendedZstdSettings = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedBrotliSettings = true;
  };
}
