all: run

build:
	cargo build

run: build
	./target/debug/reth-lighthouse

