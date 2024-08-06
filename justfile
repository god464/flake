@install target:
    nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -f .#{{ target }}
    mkdir -p /mnt/var/lib

@remote-install target ip:
    nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --flake .#{{ target }} {{ ip }}

@update:
    nix flake update

@clean:
    nix-collect-garbage -d

@upgrade:
    nixos-rebuild switch --flake .#builder

@test target:
    nixos-rebuild test --flake .#{{ target }}

@fix:
    nix-store --repair --verify --check-contents

@build:
    nix develop .#vterm
