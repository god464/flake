{
  sops.secrets =
    let
      mkSecret = x: {
        format = "binary";
        sopsFile = x;
      };
    in
    {
      host-desktop = mkSecret ./host-desktop.key;
      # host-server = mkSecret ./host-server.key;
    };
}
