install:
    nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko/vm.nix
    mkdir -p /mnt/etc/nixos
    cp -r . /mnt/etc/nixos/
    mkdir -p /mnt/var/lib
    cp /var/lib/key.txt /mnt/var/lib/key.txt
    cd /mnt/etc/nixos
    nixos-install --flake .#vm
update:
	nix flake update

clean:
	nix-collect-garbage -d

upgrade:
	nixos-rebuild switch --flake .#vm
