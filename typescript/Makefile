derivation:
	rm -rf node_modules
	node2nix --input package.json --output nix/node-packages.nix --composition nix/default.nix --node-env nix/node-env.nix

build: node2nix-init
	rm -rf result
	nix build

clean:
	rm -rf nix/* node_modules result

