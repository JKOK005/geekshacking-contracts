from web3 import Web3
import argparse
import json
import logging

"""
python3 src/main.py \
--rpc <> \
--contract_addr <> \
--mint_to <> \
--ipfs_uri <> \
--owner_address <> \
--owner_pk <>
"""

if __name__ == "__main__":
	parser 	= argparse.ArgumentParser(description='HackOMania2024 single mints')
	parser.add_argument('--rpc', type = str, nargs = '?', help = 'RPC address')
	parser.add_argument('--contract_addr', type = str, nargs = '?', help = 'Address of deployed contract')
	parser.add_argument('--mint_to', type = str, nargs = '?', help = 'Address to mint to')
	parser.add_argument('--ipfs_uri', type = str, nargs = '?', help = 'IPFS path to metadata')
	parser.add_argument('--owner_address', type = str, nargs = '?', help = 'Contract owner address')
	parser.add_argument('--owner_pk', type = str, nargs = '?', help = 'Contract owner pk')
	args 	= parser.parse_args()

	logging.info(f"{args}")

	w3 	= Web3(Web3.HTTPProvider(args.rpc))

	with open("./abi/Contract.abi") as f:
		contract_abi = json.load(f)
		contract = w3.eth.contract(address = args.contract_addr, abi = contract_abi)

	# Mint 1 nft
	raw_txn = 	contract.functions.safeMint(
					args.mint_to,
					args.ipfs_uri
				).build_transaction(
					{	
						"chainId"	: 421614,
						"gas" 		: hex(400000),
						"gasPrice"	: hex(int(w3.eth.gas_price * 2)),
						"nonce" 	: hex(w3.eth.get_transaction_count(args.owner_address)),
						"value" 	: hex(0),
						"from" 		: args.owner_address,
					}
				)

	signed 	= w3.eth.account.sign_transaction(raw_txn, args.owner_pk)
	tx_hash = w3.eth.send_raw_transaction(signed.rawTransaction)
	txn 	= w3.eth.wait_for_transaction_receipt(tx_hash, timeout = 60, poll_latency = 0.1)

	if txn["status"] == 0:
		raise Exception("Transaction Failed")