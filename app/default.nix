{
  programs = import ./program.nix;
  services = import ./service.nix;
  security = import ./security.nix;
}
