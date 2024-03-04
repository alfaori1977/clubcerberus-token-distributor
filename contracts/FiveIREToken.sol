// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FiveIREToken is ERC20 {
    uint256 public constant MAX_CLAIM_AMOUNT = 100000 ether; // Using `ether` for simplicity, assuming 18 decimals
    uint256 public constant INITIAL_SUPPLY = 21_000_000 * (10 ** 18); // Total supply of 21 Million tokens

    constructor(address deployer) ERC20("5IREToken", "5IRE") {
        _mint(deployer, 100000 ether); // Mint 100,000 tokens to deployer's address
        _mint(address(this), INITIAL_SUPPLY - 100000 ether); // Mint the rest to the contract itself for claims
    }

    function claimTokens(uint256 amount) public {
        require(
            amount <= MAX_CLAIM_AMOUNT,
            "Claim amount exceeds maximum allowed."
        );
        require(
            balanceOf(address(this)) >= amount,
            "Insufficient tokens in contract for claim."
        );
        _transfer(address(this), msg.sender, amount);
    }
}
