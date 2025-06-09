{
  config = {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        ls = "eza";
        cd = "z";
        cat = "bat";
        diff = "batdiff";
        less = "batpipe";
        rg = "batgrep";
      };
    };
  };
}
