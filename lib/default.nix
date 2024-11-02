{ inputs, self, ... }:
{
  flake.overlays.lib =
    final: _prev:
    let
      callLibs = file: import file { lib = final; };
      fn = callLibs ./fn.nix;
    in
    {
      inherit (fn) importModule';
    };
  perSystem._module.args.lib = inputs.nixpkgs.lib.extend self.overlays.lib;
}
