{
  disko.devices = {
    disk = {
      sda = {
        device = "/dev/sda";
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
                mountpoint = "/boot/nixos";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = "4G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
              };
            };
            root = {
              end = "-500M";
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                  "--csum XXHASH"
                  "-L NixOS"
                ];
                subvolumes = {
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@persist" = {
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/persist";
                  };
                  "@arch-root" = { };
                  "@arch-home" = { };
                };
              };
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "mode=755" ];
    };
  };
  fileSystems."/persist".neededForBoot = true;
}
