// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

    mapping(uint256 => WeatherData[]) public weatherHistory;

    uint256 public nextTokenId;

    constructor() ERC721("WeatherNFT", "WNFT") {}

    // Mint a new NFT
    function mintNFT(address to, string memory initialUri) external onlyOwner {
        uint256 tokenId = nextTokenId;
        _mint(to, tokenId);
        _setTokenURI(tokenId, initialUri);
        nextTokenId++;
    }

    // Update weather metadata
    function updateWeather(
        uint256 tokenId,
        int256 temperature,
        uint256 humidity,
        uint256 windSpeed,
        string memory weatherImage
    ) external onlyOwner {
        require(_exists(tokenId), "NFT does not exist");
        WeatherData memory newWeather = WeatherData(
            temperature,
            humidity,
            windSpeed,
            weatherImage,
            block.timestamp
        );
        weatherHistory[tokenId].push(newWeather);
    }

    // Retrieve current weather data
    function getCurrentWeather(uint256 tokenId)
        external
        view
        returns (WeatherData memory)
    {
        require(_exists(tokenId), "NFT does not exist");
        uint256 historyLength = weatherHistory[tokenId].length;
        require(historyLength > 0, "No weather data available");
        return weatherHistory[tokenId][historyLength - 1];
    }

    // Retrieve weather data by date range
    function getWeatherHistory(uint256 tokenId)
        external
        view
        returns (WeatherData[] memory)
    {
        require(_exists(tokenId), "NFT does not exist");
        return weatherHistory[tokenId];
    }
}