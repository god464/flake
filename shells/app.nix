{ self, ... }:
{
  perSystem.apps = {
    vm-git.program = self.nixosConfigurations.vm-git.config.microvm.declaredRunner;
    iso-desktop.program = self.nixosConfigurations.desktop.config.formats.iso;
  };
}
