{ prev }:
{
  vscode = prev.vscode.override {
    commandLineArgs = [
      "--password-store=gnome"
      "--gtk-version=4"
    ];
  };
}
