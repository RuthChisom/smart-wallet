// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
}

contract SmartWallet {
    address public owner;
    uint256 public nonce;

    // Events for better tracking
    event Executed(address indexed to, uint value, bytes data);
    event NonceIncremented(uint256 newNonce);

    constructor(address _owner) {
        owner = _owner;
    }

    // Modifier to restrict actions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    /**
     * @notice Executes a transaction to another address or contract
     * @param to Target address
     * @param value Amount of ETH to send
     * @param data Encoded function call
     */
    function execute(address to, uint value, bytes calldata data) external onlyOwner {
        require(to != address(0), "Invalid target");
        (bool success, ) = to.call{value: value}(data);
        require(success, "Call failed");
        nonce++;
        emit Executed(to, value, data);
        emit NonceIncremented(nonce);
    }

    /**
     * @notice Simulates signature validation as in EIP-4337
     * @param userOpHash The hash of the operation to validate
     * @param signature Simulated signature bytes
     */
    function validateUserOp(bytes32 userOpHash, bytes calldata signature) external pure returns (bool) {
        // Simulating signature validation — NOT SECURE!
        // In production, use ECDSA to verify signature against `owner`
        return signature.length == 65 && userOpHash != bytes32(0);
    }

    // Accept ETH
    receive() external payable {}

    // ===== Bonus Features =====

    /**
     * @notice Accept gas payment in ERC20 token (optional)
     * @param token Address of ERC20 token
     * @param amount Token amount to transfer to relayer
     * @param relayer Address that paid gas
     */
    function payGasInToken(address token, uint amount, address relayer) external onlyOwner {
        require(IERC20(token).transferFrom(msg.sender, relayer, amount), "Token transfer failed");
    }

    /**
     * @notice Batch multiple contract calls in one transaction
     * @param to Array of target addresses
     * @param value Array of ETH values
     * @param data Array of calldata for each call
     */
    function batchExecute(
        address[] calldata to,
        uint[] calldata value,
        bytes[] calldata data
    ) external onlyOwner {
        require(to.length == data.length && data.length == value.length, "Array length mismatch");

        for (uint i = 0; i < to.length; i++) {
            (bool success, ) = to[i].call{value: value[i]}(data[i]);
            require(success, "Batch call failed");
        }

        nonce++;
        emit NonceIncremented(nonce);
    }
}
