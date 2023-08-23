nix run --experimental-features 'flakes nix-command' github:nix-community/disko -- --mode disko ./disk/disko-config.nix
nixos-generate-config --no-filesystems --root /mnt
cp -r ./* /mnt/etc/nixos
cd /mnt/etc/nixos || return
nixos-install --flake .#vm
