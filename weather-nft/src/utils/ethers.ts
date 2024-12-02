import { ethers } from "ethers";
import { AVALANCHE_RPC_URL, CONTRACT_ADDRESS, ABI } from "../config";

// Créer le provider pour Avalanche Testnet
const provider = new ethers.JsonRpcProvider(AVALANCHE_RPC_URL);

// Instancier le contrat
export const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider);

// Fonction pour obtenir le signataire et connecter le portefeuille (par exemple, MetaMask)
export const getSigner = async () => {
    const ethereum = (window as any).ethereum;
    if (!ethereum) throw new Error("MetaMask is not installed!");
    
    const browserProvider = new ethers.BrowserProvider(ethereum);
    const signer = await browserProvider.getSigner();

    return signer;
};