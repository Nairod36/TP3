import React, { useState } from "react";
import { ethers } from "ethers";
import { CONTRACT_ADDRESS, AVALANCHE_RPC_URL, ABI } from "../utils/constants";

const MintNFT = () => {
  const [uri, setUri] = useState("");
  const [isMinting, setIsMinting] = useState(false);

  const mintNFT = async () => {
    try {
      setIsMinting(true);
      const provider = new ethers.JsonRpcProvider(AVALANCHE_RPC_URL);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);

      // Mint NFT with metadata URI
      const tx = await contract.mintNFT(await signer.getAddress());
      await tx.wait();  // Attendre la confirmation de la transaction
      alert("NFT Minted!");
    } catch (error) {
      console.error("Error minting NFT:", error);
      alert("Error minting NFT");
    } finally {
      setIsMinting(false);
    }
  };

  return (
    <div>
      <h2>Mint a Weather NFT</h2>
      <input
        type="text"
        placeholder="Metadata URI"
        value={uri}
        onChange={(e) => setUri(e.target.value)}
      />
      <button onClick={mintNFT} disabled={isMinting}>
        {isMinting ? "Minting..." : "Mint"}
      </button>
    </div>
  );
};

export default MintNFT;