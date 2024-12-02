// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WeatherNFT is ERC721URIStorage, Ownable {
    struct WeatherData {
        int256 temperature;
        uint256 humidity;
        uint256 windSpeed;
        string weatherImage;
        uint256 timestamp;
    }

    struct WeatherPeriod {
        WeatherData[] dailyData;
        WeatherData[] weeklyData;
        WeatherData[] monthlyData;
    }

    mapping(uint256 => WeatherPeriod) private weatherHistory;
    uint256 public nextTokenId;

    constructor(address initialOwner) ERC721("WeatherNFT", "WNFT") Ownable(initialOwner) {}

    function mintNFT(address to) external onlyOwner returns (uint256) {
        uint256 tokenId = nextTokenId;
        _mint(to, tokenId);
        nextTokenId++;
        return tokenId;
    }

    function updateWeather(
        uint256 tokenId,
        int256 temperature,
        uint256 humidity,
        uint256 windSpeed,
        string memory weatherImage
    ) external onlyOwner {
        _requireOwned(tokenId);
        
        WeatherData memory newWeather = WeatherData({
            temperature: temperature,
            humidity: humidity,
            windSpeed: windSpeed,
            weatherImage: weatherImage,
            timestamp: block.timestamp
        });

        // Ajouter aux données quotidiennes
        weatherHistory[tokenId].dailyData.push(newWeather);

        // Gérer les données hebdomadaires et mensuelles
        if (weatherHistory[tokenId].dailyData.length % 7 == 0) {
            weatherHistory[tokenId].weeklyData.push(newWeather);
        }
        
        if (weatherHistory[tokenId].dailyData.length % 30 == 0) {
            weatherHistory[tokenId].monthlyData.push(newWeather);
        }
    }

    function getCurrentWeather(uint256 tokenId) external view returns (WeatherData memory) {
        _requireOwned(tokenId);
        uint256 dailyLength = weatherHistory[tokenId].dailyData.length;
        require(dailyLength > 0, "No weather data available");
        return weatherHistory[tokenId].dailyData[dailyLength - 1];
    }

    function getWeatherHistory(
        uint256 tokenId, 
        string memory period
    ) external view returns (WeatherData[] memory) {
        _requireOwned(tokenId);
        
        if (keccak256(abi.encodePacked(period)) == keccak256(abi.encodePacked("daily"))) {
            return weatherHistory[tokenId].dailyData;
        } else if (keccak256(abi.encodePacked(period)) == keccak256(abi.encodePacked("weekly"))) {
            return weatherHistory[tokenId].weeklyData;
        } else if (keccak256(abi.encodePacked(period)) == keccak256(abi.encodePacked("monthly"))) {
            return weatherHistory[tokenId].monthlyData;
        }
        
        revert("Invalid period specified");
    }

    // Fonction pour simuler des données météorologiques factices
    function generateMockWeatherData() public view returns (WeatherData memory) {
        return WeatherData({
            temperature: 25,
            humidity: 65,
            windSpeed: 10,
            weatherImage: "sunny.png",
            timestamp: block.timestamp
        });
    }
}