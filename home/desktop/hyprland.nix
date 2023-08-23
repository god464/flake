{
  monitor = [ ",preferred,auto,auto" ];
  exec-once = [ "udiskle &" ];
  env = [ "XCURSOR_SIZE,24" ];
  input = {
    kb_layout = "us";
    numlock_by_default = true;
    follow_mouse = 1;
    touchpad = { natural_scroll = true; };
    sensitivity = 0;
  };
  general = {
    gaps_in = 5;
    gaps_out = 20;
    border_size = 2;
    "col.active_border" = [ "rgba(33ccffee) rgba(00ff99ee) 45deg" ];
    "col.inactive_border" = [ "rgba(595959aa)" ];
    layout = "dwindle";
  };

  decoration = {
    rounding = 10;
    blur = true;
    blur_size = 3;
    blur_passes = 1;
    blur_new_optimizations = true;
    drop_shadow = true;
    shadow_range = 4;
    shadow_render_power = 3;
    "col.shadow" = [ "rgba(1a1a1aee)" ];
  };
  animations = {
    enabled = true;
    bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
    animation = [
      "windows, 1, 7, myBezier"
      "windowsOut, 1, 7, default, popin 80%"
      "border, 1, 10, default"
      "borderangle, 1, 8, default"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
  };
  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };
  master = { new_is_master = true; };

  gestures = { workspace_swipe = false; };

  bind = [
    "SUPER,return,exec,kitty"
    "SUPER,w,killactive"
    "SUPER_SHIFT,q,exit"
    "SUPER,t,togglefloating"
    "SUPER,space,exec,rofi -show drun"
    "SUPER,p,pseudo"
    "SUPER,v,togglesplit"
    "SUPER,f,fullscreen"
    "SUPER_ALT,l,exec,swaylock -fF -c OMO"
    "SUPER,h,movefocus,l"
    "SUPER,l,movefocus,r"
    "SUPER,k,movefocus,u"
    "SUPER,j,movefocus,d"
    "SUPER_SHIFT,h,movewindow,l"
    "SUPER_SHIFT,l,movewindow,r"
    "SUPER_SHIFT,k,movewindow,u"
    "SUPER_SHIFT,j,movewindow,d"
    "SUPER,1,workspace,1"
    "SUPER,2,workspace,2"
    "SUPER,3,workspace,3"
    "SUPER,4,workspace,4"
    "SUPER,5,workspace,5"
    "SUPER,6,workspace,6"
    "SUPER,7,workspace,7"
    "SUPER,8,workspace,8"
    "SUPER,9,workspace,9"
    "SUPER,0,workspace,10"
    "SUPER_SHIFT,1,movetoworkspace,1"
    "SUPER_SHIFT,2,movetoworkspace,2"
    "SUPER_SHIFT,3,movetoworkspace,3"
    "SUPER_SHIFT,4,movetoworkspace,4"
    "SUPER_SHIFT,5,movetoworkspace,5"
    "SUPER_SHIFT,6,movetoworkspace,6"
    "SUPER_SHIFT,7,movetoworkspace,7"
    "SUPER_SHIFT,8,movetoworkspace,8"
    "SUPER_SHIFT,9,movetoworkspace,9"
    "SUPER_SHIFT,0,movetoworkspace,10"
    "SUPER,mouse_down,workspace,e+1"
    "SUPER,mouse_up,workspace,e-1"
  ];
  bindm = [ "SUPER,mouse:272,movewindow" "SUPER,mouse:273,resizewindow" ];
}
