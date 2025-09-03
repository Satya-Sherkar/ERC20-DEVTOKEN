// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {DeveloperToken} from "src/DevToken.sol";

contract DeployToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run() external returns (DeveloperToken) {
        vm.startBroadcast();
        DeveloperToken dt = new DeveloperToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return dt;
    }
}
