### コンソールで動作確認

```loclahot nodeの起動
yarn hardhat node
```

```
// コンソールの起動
npx hardhat console --network localhost
```

```
npx hardhat run --network localhost scripts/deploy.ts
```

```
// デプロイ済みのコントラクトに接続
const Contract = await ethers.getContractFactory("NFTExchange");
var contract = await Contract.attach([コントラクトのアドレス])

// contract.関数で、コントラクトの関数を実行できる
```

### Etherscan verify

```
npx hardhat clean
npx hardhat verify --network [ネットワーク名] [コントラクトのアドレス]
npx hardhat verify --network goerli [コントラクトのアドレス]
npx hardhat verify --network mainnet [コントラクトのアドレス]

```
