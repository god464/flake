{ config, ... }:
{
  config = {
    programs.eza = {
      enable = true;
      git = true;
      icons = "always";
    };
  };
}
