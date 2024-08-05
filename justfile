@install target:
    if [ "{{ target }}" == "builder" ]; then \
        disk="desktop"; \
    else \
        disk="server"; \
    fi; \
    ln -s ./disko/"$disk".nix ./disk-config.nix
    nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --flake .#{{ target }}
    mkdir -p /mnt/var/lib

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
