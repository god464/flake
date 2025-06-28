@install target:
    nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko -f .#{{ target }}
    mkdir -p /mnt/var/lib/sops-nix
    nixos-install --flake .#{{ target }}

@install-remote target ip:
    nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --copy-host-keys --flake .#{{ target }} root@{{ ip }}

@clean:
    nh clean all

@upgrade target="laptop":
    nh os switch . -H {{ target }}

@upgrade-remote target ip:
    nh os switch . -H {{ target }} --target-host  "root@{{ ip }}"

@test target:
    nh os test . -H {{ target }}

@fix:
    nix-store --repair --verify --check-contents

@geniso:
    nix build .#nixosConfigurations.iso.config.formats.iso

@genfacter:
    nix run github:numtide/nixos-facter -- -o facter.json
