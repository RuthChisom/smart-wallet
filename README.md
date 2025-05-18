# smart-wallet
**A basic smart wallet contract that simulates features from EIP-4337, along with a simple Paymaster contract. It includes:**

### - Owner storage
### - execute() function to send ETH or call contracts
### - Nonce to prevent replay attacks
### - validateUserOp() to simulate signature validation
### - Paymaster that logs gas sponsorship

## Bonus: ERC20 gas payments and batched calls in one trsansaction

## 🧪 Example Use
### Deploy SmartWallet with your EOA address as the owner.
### Fund the contract with ETH.
### Use execute() to send ETH or call any contract.
### Use batchExecute() for grouped operations.
### Simulate Paymaster usage by calling sponsorGas().