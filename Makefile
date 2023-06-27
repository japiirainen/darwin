.PHONY: bootstrap set-fish

bootstrap:
	nix build --extra-experimental-features 'nix-command flakes' .#darwinConfigurations.jp-mbp.system && \
	./result/sw/bin/darwin-rebuild switch --flake .

set-fish:
	chsh -s /run/current-system/sw/bin/fish

