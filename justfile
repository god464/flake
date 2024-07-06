@install target:
    if [ "{{ target }}" == "builder" ]; then \
        disk="desktop"; \
    else \
        disk="server"; \
    fi; \
    nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko/"$disk".nix
    mkdir -p /mnt/var/lib
    nixos-install --flake .#{{ target }} 

@update:
    nix flake update

@clean:
    nix-collect-garbage -d

@upgrade:
    nixos-rebuild switch --flake .#builder

@test target:
    nixos-rebuild test --flake .#{{ target }}
