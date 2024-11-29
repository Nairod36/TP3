import React, { useState } from "react";
import { contract, getSigner } from "../utils/ethers";

const MintNFT = () => {
  const [uri, setUri] = useState("");

  const mintNFT = async () => {
    try {
      const signer = await getSigner();
      const contractWithSigner = contract.connect(signer);
      const tx = await contractWithSigner.mintNFT(await signer.getAddress(), uri);
      await tx.wait();
      alert("NFT Minted!");
    } catch (error) {
      console.error("Error minting NFT:", error);
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
      <button onClick={mintNFT}>Mint</button>
    </div>
  );
};

export default MintNFT;