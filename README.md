# ERC20-DEVTOKEN

A comprehensive ERC20 token implementation built with Foundry for Ethereum development and testing.

## Overview

This project provides a complete ERC20 token smart contract implementation using the Foundry development framework. It's designed for developers who want to create, test, and deploy custom ERC20 tokens on the Ethereum blockchain.

## Features

- **Standard ERC20 Implementation**: Full compliance with the ERC20 token standard
- **Foundry Integration**: Built using Foundry's modern Rust-based toolchain
- **Comprehensive Testing**: Ready-to-use test suite for token functionality
- **Gas Optimization**: Efficient contract design for minimal gas costs
- **Developer-Friendly**: Easy to customize and extend


## Prerequisites

Before you begin, ensure you have the following installed:

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Git
- A text editor or IDE


## Installation

1. **Clone the repository**:

```bash
git clone https://github.com/Satya-Sherkar/ERC20-DEVTOKEN.git
cd ERC20-DEVTOKEN
```

2. **Install dependencies**:

```bash
forge install
```


## Usage

### Building the Project

Compile the smart contracts:

```bash
forge build
```


### Running Tests

Execute the test suite:

```bash
forge test
```

For verbose output:

```bash
forge test -vvv
```


### Code Formatting

Format your Solidity code:

```bash
forge fmt
```


### Gas Analysis

Generate gas usage snapshots:

```bash
forge snapshot
```


### Local Development

Start a local Ethereum node:

```bash
anvil
```


### Deployment

Deploy to a network:

```bash
forge script script/Deploy.s.sol:DeployScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

**Security Note**: Never use private keys directly in commands for mainnet deployments. Use environment variables or hardware wallets.

### Interacting with Contracts

Use Cast for contract interactions:

```bash
cast call <contract_address> "balanceOf(address)" <wallet_address> --rpc-url <rpc_url>
```


## Project Structure

```
ERC20-DEVTOKEN/
├── src/                    # Smart contract source files
├── script/                 # Deployment and interaction scripts
├── test/                   # Test files
├── lib/                    # Dependencies
├── foundry.toml           # Foundry configuration
└── README.md              # This file
```


## Token Configuration

The ERC20 token can be customized by modifying the following parameters in the contract:

- **Name**: The full name of your token
- **Symbol**: The ticker symbol (e.g., "DEV")
- **Decimals**: Number of decimal places (typically 18)
- **Initial Supply**: Starting token supply
- **Minting**: Whether additional tokens can be created


## Testing

The project includes comprehensive tests covering:

- Basic ERC20 functionality (transfer, approve, allowance)
- Edge cases and error conditions
- Gas optimization verification
- Security best practices

Run specific test files:

```bash
forge test --match-path test/TokenTest.t.sol
```


## Security Considerations

- Always audit your smart contracts before mainnet deployment
- Use established libraries like OpenZeppelin when possible
- Test thoroughly on testnets before mainnet deployment
- Consider implementing additional security features like pausability or access control


## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Resources

- [Foundry Documentation](https://book.getfoundry.sh/)
- [ERC20 Token Standard](https://eips.ethereum.org/EIPS/eip-20)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [Ethereum Development Resources](https://ethereum.org/developers/)


## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/Satya-Sherkar/ERC20-DEVTOKEN/issues) page
2. Create a new issue with detailed information
3. Join the community discussions

## Roadmap

- [ ] Add more advanced token features (burning, minting controls)
- [ ] Implement governance functionality
- [ ] Add frontend integration examples
- [ ] Create deployment guides for various networks
- [ ] Add automated security scanning

***

**Disclaimer**: This is educational/development software. Always perform thorough testing and security audits before deploying to mainnet with real funds.

<div style="text-align: center">⁂</div>



