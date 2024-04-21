## Build the contract
```bash
forge build
```

## Deploy the contract on Sepolia
```bash
forge create \
--rpc-url <> \
--constructor-args <arg1> <arg2> ... \
--private-key <> \
src/Contract.sol:NftSampleDeployment
```

## Pipe abi contract to python dir
```bash
jq ".abi" ./out/Contract.sol/NftSampleDeployment.json > python/abi/Contract.abi
```

## Mint 1 NFT for address
```python
python3 src/main.py \
--rpc <> \
--contract_addr <> \
--mint_to <> \
--ipfs_uri <> \
--owner_address <> \
--owner_pk <>
```