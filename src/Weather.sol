// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract WeatherNFT is ERC721URIStorage, Ownable {
    struct WeatherData {
        int256 temperature;
        uint256 humidity;
        uint256 windSpeed;
        string weatherImage;
        uint256 timestamp;
    }

    mapping(uint256 => WeatherData[]) public weatherHistory;
    uint256 public nextTokenId;

    // Constructeur : ajoute initialOwner pour Ownable
    constructor(address initialOwner) ERC721("WeatherNFT", "WNFT") Ownable(initialOwner) {}

    function mintNFT(address to, string memory initialUri) external onlyOwner {
        uint256 tokenId = nextTokenId;
        _mint(to, tokenId);
        _setTokenURI(tokenId, initialUri);
        nextTokenId++;
    }

    function updateWeather(
        uint256 tokenId,
        int256 temperature,
        uint256 humidity,
        uint256 windSpeed,
        string memory weatherImage
    ) external onlyOwner {
        _requireOwned(tokenId);
        WeatherData memory newWeather = WeatherData(
            temperature,
            humidity,
            windSpeed,
            weatherImage,
            block.timestamp
        );
        weatherHistory[tokenId].push(newWeather);
    }

    function getCurrentWeather(uint256 tokenId)
        external
        view
        returns (WeatherData memory)
    {
        _requireOwned(tokenId);
        uint256 historyLength = weatherHistory[tokenId].length;
        require(historyLength > 0, "No weather data available");
        return weatherHistory[tokenId][historyLength - 1];
    }

    function getWeatherHistory(uint256 tokenId)
        external
        view
        returns (WeatherData[] memory)
    {
        _requireOwned(tokenId);
        return weatherHistory[tokenId];
    }
}