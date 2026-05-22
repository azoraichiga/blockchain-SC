# Blockchain Smart Contract
# Course Reward System

Smart contract reward system for students using Solidity and Hardhat.

## Features

- Owner can set reward amount
- Students can claim reward once
- Whitelist system
- Deadline claim
- Multiple reward tiers
- Event logging

## Installation

```bash
npm install
```

## Compile

```bash
npx hardhat compile
```

## Test

```bash
npx hardhat test
```

## Run Local Blockchain

```bash
npx hardhat node
```

## Deploy

```bash
npx hardhat run scripts/deploy.js --network localhost
```

## MetaMask Setup

- Add Localhost Network
- RPC URL:
  http://127.0.0.1:8545
- Chain ID:
  31337

## Import Account

Copy private key from hardhat node output.
