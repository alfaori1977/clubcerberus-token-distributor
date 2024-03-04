// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenDistributor is Ownable {
    constructor(address initialOwner) Ownable(initialOwner) {}

    struct Distribution {
        address tokenAddress;
        uint256 amount;
        bool claimed;
    }

    mapping(address => Distribution[]) public distributions;

    event TokensDeposited(
        address indexed tokenAddress,
        uint256 amount,
        address[] recipients
    );
    event TokensClaimed(
        address indexed user,
        address indexed tokenAddress,
        uint256 amount
    );

    function depositTokens(
        address _tokenAddress,
        uint256[] calldata _amounts,
        address[] calldata _recipients
    ) external onlyOwner {
        require(
            _amounts.length == _recipients.length,
            "Amounts and recipients length mismatch"
        );
        IERC20 token = IERC20(_tokenAddress);
        uint256 totalAmount = 0;
        for (uint256 i = 0; i < _amounts.length; i++) {
            distributions[_recipients[i]].push(
                Distribution({
                    tokenAddress: _tokenAddress,
                    amount: _amounts[i],
                    claimed: false
                })
            );
            totalAmount += _amounts[i];
        }
        require(
            token.transferFrom(msg.sender, address(this), totalAmount),
            "Transfer failed"
        );
        emit TokensDeposited(_tokenAddress, totalAmount, _recipients);
    }
}
