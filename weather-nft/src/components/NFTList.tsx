import React, { useEffect, useState } from "react";
import { contract } from "../utils/ethers";

const NFTList = () => {
    const [nfts, setNfts] = useState<any[]>([]);

    const fetchNFTs = async () => {
        try {
            // Accéder directement à la variable publique nextTokenId
            const totalSupply = await contract.nextTokenId(); // Cette ligne fonctionne maintenant correctement.
            const nftData = [];
            for (let i = 0; i < totalSupply; i++) {
                try {
                    const weatherData = await contract.getCurrentWeather(i);
                    nftData.push({ tokenId: i, ...weatherData });
                } catch (err) {
                    console.error(`Error fetching NFT ${i}`, err);
                }
            }
            setNfts(nftData);
        } catch (err) {
            console.error("Error fetching total supply", err);
        }
    };

    useEffect(() => {
        fetchNFTs();
    }, []);

    return (
        <div>
            <h1>Weather NFTs</h1>
            <ul>
                {nfts.map((nft) => (
                    <li key={nft.tokenId}>
                        <p>Token ID: {nft.tokenId}</p>
                        <p>Temperature: {nft.temperature}°C</p>
                        <p>Humidity: {nft.humidity}%</p>
                        <p>Wind Speed: {nft.windSpeed} km/h</p>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default NFTList;