bootstrap:
	nix build --extra-experimental-features 'nix-command flakes' .#darwinConfigurations.jp-mbp.system && \
	./result/sw/bin/darwin-rebuild switch --flake .

