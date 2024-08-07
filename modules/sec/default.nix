{
  config = {
    sops = {
      age = {
        keyFile = "/var/lib/key.txt";
        generateKey = true;
      };
      defaultSopsFile = ./secrets.yaml;
      secrets.passwd.neededForUsers = true;
    };
    services.dbus.apparmor = "enabled";
    security = {
      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
      };
      sudo = {
        enable = true;
        execWheelOnly = true;
      };
      auditd.enable = true;
      audit.enable = true;
    };
  };
}
