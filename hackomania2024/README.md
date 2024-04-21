## HackOMania 2024 NFT minting
[HackOMania2024](https://hackomania.geekshacking.com/) is over! 

These NFTs are only for claim for those who organized the event. 

## Procedure to deploy the contract
### Setting up the repo
Initialize a new repository using `forge`
```bash
forge init
```

Install openzepplin dependencies

```bash
forge install OpenZeppelin/openzeppelin-contracts
```

### Deploying the contract
```bash
forge create \
--rpc-url <> \
--constructor-args <arg1> <arg2> ... \
--private-key <> \
src/Contract.sol:NftSampleDeployment
```

### Pipe abi contract to python dir
```bash
jq ".abi" ./out/Contract.sol/HackOMania2024Contract.json > python/abi/Contract.abi
```

### Minting NFTs 
To mint for a single address
```python
python3 src/mint_single.py \
--rpc <> \
--contract_addr <> \
--mint_to <> \
--ipfs_uri <> \
--owner_address <> \
--owner_pk <>
```

To mint for a batch of addresses
```python
python3 src/mint_batch.py \
--rpc <> \
--contract_addr <> \
--mint_alllTo <> \
--ipfs_uri <> \
--owner_address <> \
--owner_pk <>
```