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

# Execution Client

## Build Reth

With Rust and the dependencies installed, you're ready to build Reth. First, clone the repository:

```bash
cd reth
```

Then, install Reth into your `PATH` directly via:

```bash
cargo install --locked --path bin/reth --bin reth
```


## Update Reth

You can update Reth to a specific version by running the commands below.

The `reth` directory will be the location you cloned reth to during the installation process.

`${VERSION}` will be the version you wish to build in the format `vX.X.X`.

```bash
cd reth
git fetch
git checkout ${VERSION}
cargo build --release
```

# Consensus Client

## Build Lighthouse

Once you have Rust and the build dependencies you're ready to build Lighthouse:

```
cd lighthouse
```

```
git checkout stable
```

```
make
```

## Update Lighthouse

You can update Lighthouse to a specific version by running the commands below. The `lighthouse`
directory will be the location you cloned Lighthouse to during the installation process.
`${VERSION}` will be the version you wish to build in the format `vX.X.X`.

```
cd lighthouse
```

```
git fetch
```

```
git checkout ${VERSION}
```

```
make
```

## Configure Lighthouse


### Import Validator Keys:

```
lighthouse \
  --network mainnet \
  --datadir ~/crypto/.lighthouse 
  account validator import \
  --directory ~/crypto/validator_keys
```

#### Setting the fee recipient in the `validator_definitions.yml`

Users can set the fee recipient in `validator_definitions.yml` with the `suggested_fee_recipient`
key. This option is recommended for most users, where each validator has a fixed fee recipient.

Below is an example of the validator_definitions.yml with `suggested_fee_recipient` values:

```
- enabled: true
  voting_public_key: "0x87a580d31d7bc69069b55f5a01995a610dd391a26dc9e36e81057a17211983a79266800ab8531f21f1083d7d84085007"
  type: local_keystore
  voting_keystore_path: /home/paul/.lighthouse/validators/0x87a580d31d7bc69069b55f5a01995a610dd391a26dc9e36e81057a17211983a79266800ab8531f21f1083d7d84085007/voting-keystore.json
  voting_keystore_password_path: /home/paul/.lighthouse/secrets/0x87a580d31d7bc69069b55f5a01995a610dd391a26dc9e36e81057a17211983a79266800ab8531f21f1083d7d84085007
  suggested_fee_recipient: "0x6cc8dcbca744a6e4ffedb98e1d0df903b10abd21"
```



# Run reth-lighthouse


## Run the Reth Node

Now, to start the full node, run:

```bash
reth node --full --http --ws --http.api --ws.api
```


## Run the Lighthouse Node

Execute Beacon Node:

```
lighthouse bn \
  --checkpoint-sync-url https://mainnet.checkpoint.sigp.io \
  --network mainnet \
  --datadir ~/crypto/.lighthouse \
  --http \
  --execution-endpoint http://localhost:8551 \
  --execution-jwt ~/.local/share/reth/jwt.hex \
```

Execute Validator Client:

```
lighthouse validator \
  --network mainnet \
  --datadir ~/crypto/.lighthouse \
  --http \
  --builder-proposals
```
