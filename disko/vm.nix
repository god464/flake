{ disks ? [ "/dev/sda" ], ... }: {
  disko.devices = {
    disk = {
      sda = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                mountpoint = "/";
                subvolumes = {
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions =
                      [ "compress=zstd:15" "noatime" "csum=SHA256" ];
                  };
                  "@root" = {
                    mountpoint = "/root";
                    mountOptions =
                      [ "compress=zstd:15" "noatime" "csum=SHA256" ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions =
                      [ "compress=zstd:15" "noatime" "csum=SHA256" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
