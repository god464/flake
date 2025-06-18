{ prev }:
{
  prev.chromium = prev.chromium.override {
    commandLineArgs = [
      "--enable-features=AcceleratedVideoEncoder"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
    ];
  };
}
