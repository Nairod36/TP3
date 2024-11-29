// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/NFT.sol";

contract DeployNFT is Script {
    function run() external {
        uint256 depolyPK = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(depolyPK);
        EvolvingNFT evolvingNFT = new EvolvingNFT();
        vm.stopBroadcast();

        console.log("Deployed NFT contract at:", address(evolvingNFT));
    }
}
