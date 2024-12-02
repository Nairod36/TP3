// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Weather.sol";

contract DeployWeatherNFT is Script {
    function run() external returns (WeatherNFT) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        vm.startBroadcast(deployerPrivateKey);
        WeatherNFT weatherNFT = new WeatherNFT(deployer);
        vm.stopBroadcast();
        
        return weatherNFT;
    }
}