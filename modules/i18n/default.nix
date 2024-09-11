{
  config = {
    time.timeZone = "Asia/Shanghai";
    i18n = {
      defaultLocale = "C.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "zh_CN.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        LC_Time = "C.UTF-8";
        LC_CTYPE = "zh_CN.UTF-8";
      };
    };
    console.useXkbConfig = true;
  };
}
