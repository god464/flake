[group('nixos')]
[linux]
@install target:
    nix-shell -p disko --run "disko -- -m destroy,format,mount -f .#{{ target }}"
    nixos-install --flake .#{{ target }}

[group('nixos')]
[linux]
@install-remote target ip:
    nix run nixpkgs#nixos-anywhere -- --copy-host-keys --flake .#{{ target }} root@{{ ip }}

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
    nixos-rebuild build-image --flake .#iso

[group('facter')]
@genfacter:
    nix run github:numtide/nixos-facter -- -o facter.json
