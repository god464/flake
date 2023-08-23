{pkgs,...}:
{
wayland.windowManager.hyprland={
enable=true;
settings = import ./hyprland.nix;
};
 waybar = {
      enable = true;
      settings = import ./waybar/cl.nix;
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      pass = {
        enable = true;
      };
    };
	kitty = {
      enable = true;
      font.name = "JetBrainsMonoNL Nerd Font Mono";
      theme = "Tokyo Night";
    };
	swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };
	 services = {
    mako = {
      enable = true;
    };
    swayidle = {
      enable = true;
      systemdTarget = "hyprland-session.target";
    };
  };
		   }
