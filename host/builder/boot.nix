{
  loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      gfxmodeEfi = "auto";
      gfxmodeBios = "auto";
      gfxpayloadEfi = "auto";
      gfxpayloadBios = "auto";
    };
  };
  plymouth.enable = true;
  consoleLogLevel = 0;
  kernelParams = [ "quiet" "splash" ];
}
