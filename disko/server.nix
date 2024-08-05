{lib,...}:
{
  disko.devices = {
    disk = {
      sda = {
        device = lib.mkDefault "/dev/sda";
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
                extraArgs = [
                  "-f"
                  "--csum SHA256"
                  "-L NixOS"
                ];
                mountpoint = "/";
                mountOptions = [
                  "compress=zstd:15"
                  "noatime"
                ];
              };
            };
          };
        };
      };
    };
  };
}
