// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Paymaster {
    event GasSponsored(address indexed user, uint256 amount);

    /**
     * @notice Simulates gas sponsorship logic
     * @param user Address of the user whose gas is sponsored
     * @param amount Simulated gas cost
     */
    function sponsorGas(address user, uint256 amount) external {
        // In a real case, you’d have balances and logic to pay gas
        emit GasSponsored(user, amount);
    }
}
