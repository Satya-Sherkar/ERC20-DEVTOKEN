// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DeveloperToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Developer's Token", "DT") {
        _mint(msg.sender, initialSupply);
    }
}
