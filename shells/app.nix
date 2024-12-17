{ self, ... }:
{
  perSystem.apps = {
    vm-git.program = self.nixosConfigurations.vm-git.config.microvm.declaredRunner;
  };
}
