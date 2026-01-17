[group('nixos')]
[linux]
@install target:
    nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest --mode destroy,format,mount -f .#{{ target }}
    mkdir -p /mnt/var/lib/sops-nix
    nixos-install --flake .#{{ target }}

[group('nixos')]
[linux]
@install-remote target ip:
    nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --copy-host-keys --flake .#{{ target }} root@{{ ip }}

[group('nix')]
@clean:
    nix-collect-garbage -d

[group('nix')]
[linux]
@upgrade target="laptop":
    nh os switch . -H {{ target }}

[group('nix')]
[linux]
@lazy-upgrade target="laptop":
    nh os boot . -H {{ target }}

[group('nix')]
@upgrade-remote target ip:
    nh os switch . -H {{ target }} --target-host  "root@{{ ip }}"

[group('nix')]
@test target:
    nh os test . -H {{ target }}

[group('nix')]
@fix:
    nix-store --repair --verify --check-contents

[group('iso')]
@geniso:
    nix build .#nixosConfigurations.iso.config.formats.install-iso-hyperv

[group('facter')]
@genfacter:
    nix run github:numtide/nixos-facter -- -o facter.json
