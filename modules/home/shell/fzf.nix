{ config, ... }:
{
  config = {
    programs.fzf = {
      enable = true;
      defaultCommand = "fd –type f –follow –exclude .git";
    };
  };
}
