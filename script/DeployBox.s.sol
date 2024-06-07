// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";


contract DeployBox is Script {

    function run() external returns (address) {
        address proxy = deployBox();    
        return proxy;
    }

    function deployBox() public returns (address) {
        vm.startBroadcast();
        BoxV1 box = new BoxV1();
        // The second argument is the data that will be passed to the BoxV1 initialize function
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), "");
        // If needed call the initialize function of the BoxV1 contract
        // box.initialize();
        vm.stopBroadcast();
        return address(proxy);
    }
}