## Foundry AVALANCHE TP3

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Weather.s.sol:WeatherNFT --rpc-url <your_rpc_url> --private-key <your_private_key>
```
 ![image](https://github.com/user-attachments/assets/100dfde7-4a92-4b8e-884b-023e5625c64e)

● Le “mint” des NFTs et la mise à jour périodique des
métadonnées des NFTs avec des données météorologiques
actuelles telles que
○ la température,
○ l'humidité,
○ la vitesse du vent,
○ une image représentant les conditions météorologiques.
○ Autre information…
● Vous pouvez utiliser des données factices pour simuler les
informations météorologiques.
● Les utilisateurs devraient pouvoir récupérer les informations
météorologiques pour aujourd'hui, la semaine dernière ou le
mois dernier.
