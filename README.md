Ubuntu Packages:
----------------

sudo apt install -y git gcc g++ make cmake pkg-config llvm-dev libclang-dev clang curl openssh-server vim screen htop 


Rust:
-----

# Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Update to latest stable version of rust
rustup update stable


Execution Engine:
-------------

Version:

geth version


Install:

sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum


Update:

sudo apt-get update
sudo apt-get install ethereum
sudo apt-get upgrade geth


Execute:

geth --http --datadir ~/crypto/.ethereum/ --datadir.ancient /media/julian/ethereum/chaindata/ancient/ --authrpc.addr localhost --authrpc.port 8551 --authrpc.vhosts localhost

Consensus Engine:
-------------

Build:

git clone https://github.com/sigp/lighthouse.git
cd lighthouse
git checkout stable
make


Update:

cd lighthouse
git fetch
git checkout stable
make


Import Validator Keys:

lighthouse \
  --network mainnet \
  --datadir ~/crypto/.lighthouse 
  account validator import \
  --directory ~/crypto/validator_keys


Execute Beacon Node:

lighthouse \
  --network mainnet \
  --datadir ~/crypto/.lighthouse beacon \
  --http \
  --execution-endpoint http://localhost:8551 \
  --execution-jwt ~/crypto/.ethereum/geth/jwtsecret \
  --builder http://127.0.0.1:18550

Execute Validator Client:

lighthouse \
  --network mainnet \
  --datadir ~/crypto/.lighthouse validator \
  --http \
  --graffiti "yusa.eth" \
  --suggested-fee-recipient "0x0073245E2BF4f38400634D4bA7527bbD34bFc6ba" \
  --builder-proposals

MEV-Boost:
-----------------------

vi /etc/systemd/system/mevboost.service

sudo service mevboost status


Mount SSD:
------------------

sudo mount /dev/sda1 /media/julian/ethereum/


julian@ethereum:~$ date
Fr 29. Sep 23:25:56 CEST 2023
julian@ethereum:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           3,2G  2,2M  3,2G   1% /run
/dev/nvme0n1p3  1,8T  1,3T  476G  73% /
tmpfs            16G     0   16G   0% /dev/shm
tmpfs           5,0M  4,0K  5,0M   1% /run/lock
/dev/nvme0n1p2  512M  6,1M  506M   2% /boot/efi
tmpfs           3,2G   72K  3,2G   1% /run/user/127
tmpfs           3,2G   60K  3,2G   1% /run/user/1000
/dev/sda1       916G  569G  301G  66% /media/julian/ethereum

