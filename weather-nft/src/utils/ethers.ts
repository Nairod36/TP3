import { BrowserProvider } from "ethers";
import { AVALANCHE_RPC_URL, CONTRACT_ADDRESS, ABI } from "../config";
import { JsonRpcProvider } from "ethers";
import { Contract } from "ethers";

const provider = new JsonRpcProvider(AVALANCHE_RPC_URL);
export const contract = new Contract(CONTRACT_ADDRESS, ABI, provider);


export const getSigner = async () => {
    const ethereum = (window as any).ethereum;
    if (!ethereum) throw new Error("Metamask is not installed!");
    const browserProvider = new BrowserProvider(ethereum);
    return await browserProvider.getSigner();
};
