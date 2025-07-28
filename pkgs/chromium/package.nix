{ prev }:
{
  chromium = prev.ungoogled-chromium.override {
    commandLineArgs = [
      "--enable-features=AcceleratedVideoEncoder"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
      "--gtk-version=4"
    ];
  };
}
