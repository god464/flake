@install target:
    nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko -f .#{{ target }}
    mkdir -p /mnt/var/lib/sops-nix
    nixos-install --flake .#{{ target }}

@install-remote target ip:
    nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --copy-host-keys --flake .#{{ target }} root@{{ ip }}

@update:
    nix flake update

@clean:
    nix-collect-garbage -d

@upgrade target="laptop":
    nixos-rebuild switch --flake .#{{ target }}

@upgrade-remote target ip:
    nixos-rebuild switch --flake .#{{ target }} --target-host "root@{{ ip }}"

@test target:
    nixos-rebuild test --flake .#{{ target }}

@fix:
    nix-store --repair --verify --check-contents

@geniso:
    nix build .#nixosConfigurations.desktop.config.formats.iso

@genfacter:
    nix run github:numtide/nixos-facter -- -o facter.json
