# JobContract
An Ethereum smart contract for applying and paying for services using Ether without the need of two parties to trust a third party that would hold the funds in the time of execution. Thus two parties can exchange services with as trustless as possible.

## How it works?
- This projects contains a JobContract that represents an Ethereum smart contract. This contract is created by the second contract in this project named JobContractParent which calls a constructor to create a new JobContract without needing to compile it separately. 
- Truffle testing framework is used to present the contracts and their functionalities and needs to be installed if needed.

## Installation
First install Truffle:

```shell
npm install -g truffle
```

## Compiling
After truffle is installed you can compile the contracts in the /contracts folder like:
```shell
truffle compile
```
This writes artifacts to ./build/contracts which you can use to test your contract and deploy it to the main net.

## Deploying
Deploying can be done in multiple ways. I currently prefer using Remix, an Ethereum browser IDE.  
However for doing it via truffle you can use:
```shell
truffle migrate
```
However for more on using truffle for compilation and deployment refer:
https://medium.com/@gus_tavo_guim/using-truffle-to-create-and-deploy-smart-contracts-95d65df626a2

## Tests
Tests in truffle for this smart contract are still to be programmed.
