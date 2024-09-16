{
  config = {
    time.timeZone = "Asia/Shanghai";
    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "zh_CN.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        LC_CTYPE = "zh_CN.UTF-8";
      };
    };
    console.useXkbConfig = true;
  };
}
