import React from "react";
import NFTList from "./components/NFTList";
import MintNFT from "./components/MintNFT";

const App = () => {
    return (
        <div>
            <MintNFT />
            <NFTList />
        </div>
    );
};

export default App;