{
  disko.devices = {
    disk.sda = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          root = {
            label = "ROOT";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [
                "-f"
                "-L Nixos"
              ];
              mountpoint = "/";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
              subvolumes = {
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "@var" = {
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                  mountpoint = "/var";
                };
              };
            };
          };
        };
      };
    };
  };
}
