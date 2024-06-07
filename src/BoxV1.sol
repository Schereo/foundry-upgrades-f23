//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 private number;

    // Not necessary but a good practice to show no constructor should be called
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        // Example how to use the Ownable in the context of upgradable contracts
        __Ownable_init(msg.sender); 
        // Doesnt to anything, just best practice to show this an upgradable contract
        __UUPSUpgradeable_init();
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    // Leaving this function empty means that everyone can upgrade the contract.
    function _authorizeUpgrade(address newImplementation) internal override {}
}
