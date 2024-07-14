# Reth Lighthouse Node

The **reth-lighthouse** repository is an opinionated, rust-based, build-by-source Ethereum node installation guide for Ubuntu 24.04 LTS. This is a guide for people that resonate with the idea of building their Ethereum node from source and appreciate the efficient rust-based clients Reth and Lighthouse. This repository acts as a one-stop shop for your Ethereum node, condensed all required information in a single README.

In the future I might add more infrastructure to the repository that works with this setup.

## Dependencies

First, **install Rust** using [rustup](https://rustup.rs/)：

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Update to latest stable version of rust:
```bash
rustup update stable
```


Install the following packages:

```bash
sudo apt update && sudo apt install -y git build-essential gcc g++ make cmake pkg-config llvm-dev libclang-dev clang curl openssh-server vim screen htop 
```


Init submodules:

```bash
git submodule update --init
```

## Execution Client

### Build Reth

With Rust and the dependencies installed, you're ready to build Reth.

```bash
cd reth
git fetch
git checkout main
cargo install --locked --path bin/reth --bin reth
```

## Consensus Client

### Build Lighthouse

Once you have Rust and the build dependencies installed, you're ready to build Lighthouse.

```bash
cd lighthouse
git fetch
git checkout stable
make
```


### Configure Lighthouse


#### Import Validator Keys:

```bash
lighthouse \
  --network mainnet \
  --datadir ~/.lighthouse 
  account validator import \
  --directory ~/crypto/validator_keys
```

#### Setting the fee recipient in the `validator_definitions.yml`

Users can set the fee recipient in `validator_definitions.yml` with the `suggested_fee_recipient`
key. This option is recommended for most users, where each validator has a fixed fee recipient.

Below is an example of the validator_definitions.yml with `suggested_fee_recipient` values:

```bash
  suggested_fee_recipient: "0x6cc8dcbca744a6e4ffedb98e1d0df903b10abd21"
```



## Run reth-lighthouse


### Run the Reth Node

Now, to start the full node, run:

```bash
reth node --full --datadir ~/.reth --http --http.api all
```


### Run the Lighthouse Node

Execute Beacon Node:

```
lighthouse bn \
  --checkpoint-sync-url https://beaconstate.ethstaker.cc \
  --network mainnet \
  --datadir ~/.lighthouse \
  --http \
  --execution-endpoint http://localhost:8551 \
  --execution-jwt ~/.reth/jwt.hex
```

Execute Validator Client:

```
lighthouse vc \
  --network mainnet \
  --datadir ~/.lighthouse \
  --http
```
