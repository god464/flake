{
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
}
