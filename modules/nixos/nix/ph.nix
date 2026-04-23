{ inputs, ... }:
{
  imports = [ inputs.ph.nixosModules.default ];
  programs.ph.enable = true;
}
