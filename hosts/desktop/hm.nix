{ inputs, ... }:
{
  programs.wezterm.enable = true;
  xdg.configFile.wezterm = {
    source = inputs.ggterm;
    recursive = true;
  };
}
