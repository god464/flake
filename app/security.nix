{
  apparmor = {
    enable = true;
    enableCache = true;
    killUnconfinedConfinables = true;
  };
  sudo-rs = {
    enable = true;
    execWheelOnly = true;
  };
  auditd.enable = true;
  audit.enable = true;
}
