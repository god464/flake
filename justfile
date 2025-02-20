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

@upgrade target="desktop":
    nixos-rebuild switch --flake .#{{ target }}

@upgrade-remote target ip:
    nixos-rebuild switch --flake .#{{ target }} --target-host "root@{{ ip }}"

@test target:
    nixos-rebuild test --flake .#{{ target }}

@fix:
    nix-store --repair --verify --check-contents

@runvm:
    nix run .#nixosConfigurations.vm-deploy.config.microvm.declaredRunner

@geniso:
    nix build .#nixosConfigurations.desktop.config.formats.iso

@genfacter:
    nix run --option extra-substituters https://numtide.cachix.org --option extra-trusted-public-keys numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE= github:numtide/nixos-facter -- -o facter.json
