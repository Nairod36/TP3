// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Weather.sol";

contract WeatherNFTTest is Test {
    WeatherNFT public weatherNFT;
    address public owner;
    address public testUser;
    address public alternateSender;

    function setUp() public {
        owner = address(this);
        testUser = address(0x123);
        alternateSender = address(0x456);
        weatherNFT = new WeatherNFT(owner);
    }

    // Mint NFT Tests
    function testMintNFT() public {
        uint256 tokenId = weatherNFT.mintNFT(testUser);
        assertEq(weatherNFT.ownerOf(tokenId), testUser, "Token should be minted to specified address");
    }

    function testMintNFTMultipleTimes() public {
        uint256 firstTokenId = weatherNFT.mintNFT(testUser);
        uint256 secondTokenId = weatherNFT.mintNFT(testUser);
        
        assertEq(firstTokenId, 0, "First token ID should be 0");
        assertEq(secondTokenId, 1, "Second token ID should be 1");
        assertEq(weatherNFT.ownerOf(firstTokenId), testUser, "First token owner should be correct");
        assertEq(weatherNFT.ownerOf(secondTokenId), testUser, "Second token owner should be correct");
    }

    function testCannotMintNFTByNonOwner() public {
        vm.prank(alternateSender);
        vm.expectRevert();
        weatherNFT.mintNFT(testUser);
    }

    // Weather Update Tests
    function testUpdateWeather() public {
        uint256 tokenId = weatherNFT.mintNFT(testUser);
        
        vm.prank(owner);
        weatherNFT.updateWeather(
            tokenId, 
            25, 
            65, 
            10, 
            "sunny.png"
        );

        WeatherNFT.WeatherData memory currentWeather = weatherNFT.getCurrentWeather(tokenId);
        
        assertEq(currentWeather.temperature, 25, "Temperature should match");
        assertEq(currentWeather.humidity, 65, "Humidity should match");
        assertEq(currentWeather.windSpeed, 10, "Wind speed should match");
        assertEq(keccak256(abi.encodePacked(currentWeather.weatherImage)), 
                 keccak256(abi.encodePacked("sunny.png")), 
                 "Weather image should match");
    }

    function testUpdateWeatherMultipleTimes() public {
        uint256 tokenId = weatherNFT.mintNFT(testUser);
        
        vm.prank(owner);
        weatherNFT.updateWeather(
            tokenId, 
            25, 
            65, 
            10, 
            "sunny.png"
        );

        vm.prank(owner);
        weatherNFT.updateWeather(
            tokenId, 
            30, 
            70, 
            15, 
            "cloudy.png"
        );

        WeatherNFT.WeatherData memory currentWeather = weatherNFT.getCurrentWeather(tokenId);
        
        assertEq(currentWeather.temperature, 30, "Latest temperature should be updated");
        assertEq(currentWeather.humidity, 70, "Latest humidity should be updated");
    }

    function testCannotUpdateWeatherForNonOwnedToken() public {
        uint256 tokenId = weatherNFT.mintNFT(testUser);
        
        vm.prank(alternateSender);
        vm.expectRevert();
        weatherNFT.updateWeather(
            tokenId, 
            25, 
            65, 
            10, 
            "sunny.png"
        );
    }

    // Weather History Tests
    function testGetWeatherHistory() public {
        uint256 tokenId = weatherNFT.mintNFT(testUser);
        
        vm.prank(owner);
        weatherNFT.updateWeather(
            tokenId, 
            25, 
            65, 
            10, 
            "sunny.png"
        );

        vm.prank(owner);
        weatherNFT.updateWeather(
            tokenId, 
            30, 
            70, 
            15, 
            "cloudy.png"
        );

        WeatherNFT.WeatherData[] memory dailyHistory = weatherNFT.getWeatherHistory(tokenId, "daily");
        
        assertEq(dailyHistory.length, 2, "Daily history should have two entries");
        assertEq(dailyHistory[0].temperature, 25, "First daily entry temperature should match");
        assertEq(dailyHistory[1].temperature, 30, "Second daily entry temperature should match");
    }

    function testGetWeatherHistoryInvalidPeriod() public {
        uint256 tokenId = weatherNFT.mintNFT(testUser);
        
        vm.prank(owner);
        weatherNFT.updateWeather(
            tokenId, 
            25, 
            65, 
            10, 
            "sunny.png"
        );

        vm.expectRevert("Invalid period specified");
        weatherNFT.getWeatherHistory(tokenId, "invalid");
    }

    function testGetCurrentWeatherNoData() public {
        uint256 tokenId = weatherNFT.mintNFT(testUser);
        
        vm.expectRevert("No weather data available");
        weatherNFT.getCurrentWeather(tokenId);
    }

    // Generate Mock Weather Data Test
    function testGenerateMockWeatherData() public {
        WeatherNFT.WeatherData memory mockData = weatherNFT.generateMockWeatherData();
        
        assertEq(mockData.temperature, 25, "Mock temperature should be correct");
        assertEq(mockData.humidity, 65, "Mock humidity should be correct");
        assertEq(mockData.windSpeed, 10, "Mock wind speed should be correct");
        assertEq(keccak256(abi.encodePacked(mockData.weatherImage)), 
                 keccak256(abi.encodePacked("sunny.png")), 
                 "Mock weather image should be correct");
    }
}