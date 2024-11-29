// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Weather.sol";

contract DeployWeatherNFT is Script {
    function run() external {
        address deployer = msg.sender; // Adresse du déployeur
        vm.startBroadcast();
        new WeatherNFT(deployer); // Passer l'adresse du propriétaire initial
        vm.stopBroadcast();
    }
}