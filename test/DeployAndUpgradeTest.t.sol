// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox public deployer;
    UpgradeBox public upgrader;
    address public OWNER = makeAddr("OWNER");   

    address public proxy;

    function setUp() external {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run();
    }

    function testProxyStartsAsBoxV1() external {
        vm.expectRevert();
        // Box is not upgraded yet, so it should be BoxV1 and has no setNumber function
        BoxV2(proxy).setNumber(23);
    }

    function testUpgrades() external {
        BoxV2 boxV2 = new BoxV2();
        upgrader.upgradeBox(proxy, address(boxV2));

        uint256 expectedVersion = 2;
        uint256 actualVersion = BoxV2(proxy).version();
        assert(expectedVersion == actualVersion);
    }
}