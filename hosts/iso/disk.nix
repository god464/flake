{
  disko.devices = {
    disk.sda = {
      type = "disk";
      device = "/dev/sda1";
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
            size = "100%";
            label = "ROOT";
            content = {
              type = "btrfs";
              extraArgs = [
                "-f"
                "-L NixOS"
              ];
              mountpoint = "/";
              mountOptions = [
                "csum=xxhash"
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
