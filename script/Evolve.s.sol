// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/EvolvingNFT.sol";

contract UpdateMetadata is Script {
    function run(uint256 tokenId, string memory newURI) external {
        address nftAddress = <ADRESSE_DU_CONTRAT>;
        EvolvingNFT evolvingNFT = EvolvingNFT(nftAddress);

        vm.startBroadcast();
        evolvingNFT.updateTokenURI(tokenId, newURI);
        vm.stopBroadcast();
    }
}
