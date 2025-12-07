# Copilot Instructions for blockchain-tech

## Project Overview
This is a **Real World Assets (RWA) tokenization** educational repository focused on Solidity smart contracts and blockchain fundamentals. The goal is to demonstrate how real-world assets (like real estate, commodities, bonds) can be tokenized on Ethereum while maintaining compliance and proper governance.

## Architecture & Core Concepts

### RWA Compliance Model
The project implements a three-tier RWA pattern exemplified in `contracts/Sample.sol`:

1. **KYC Verification Layer** (`isKYC` mapping): Only whitelisted addresses can hold/transfer tokens
2. **Asset Minting** (`mint()`, `burn()`): Issuer controls token supply tied to off-chain asset backing
3. **Transfer Restrictions** (`_update()` override): Unlike standard ERC-20, transfers require KYC verification on both sender and receiver

**Key Pattern**: Override the `_update()` internal function to enforce compliance rules rather than creating a new transfer wrapper.

### Smart Contract Hierarchy
- **SimpleRWA** (`Sample.sol`): Production-ready RWA token combining ERC20 + Ownable with KYC enforcement
- **BasicContracts** (`Storage.sol`, `HelloWorld.sol`, `SimpleContract.sol`): Learning examples showing state management, events, and modifiers

### Critical Developer Workflows

#### Local Testing & Deployment
- **Tool**: Hardhat (referenced in `workflow.md` but not packaged)
- **Setup**: Install with `npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox`
- **Compile**: `npx hardhat compile` generates ABIs in `contracts/artifacts/`
- **Key Artifact Pattern**: Metadata JSON files store full contract info; use for ABI binding to Scaffold-ETH

#### Demo Scenario Flow (from workflow.md)
Implement this sequence for RWA demonstrations:
1. Admin adds user to whitelist via `setKYC(user, true)`
2. Admin mints tokens via `mint(user, amount)` - requires KYC check
3. User A transfers to User B - transfers fail if B not in KYC whitelist
4. Admin force-transfers using low-level authority (future enhancement)
5. Users burn tokens to redeem physical assets

#### Integration with Chainlink (Recommended)
- **Data Feeds**: Pull real-time asset prices (gold, real estate values)
- **Functions**: Execute off-chain APIs to fetch asset reserve proofs from banks
- See `workflow.md` lines 29-31 for rationale

### Project-Specific Conventions

#### Solidity Version & Imports
- Use `pragma solidity ^0.8.20` (newest stable)
- Always import from `@openzeppelin/contracts` for standard patterns:
  - `ERC20` for token mechanics
  - `Ownable` for access control
  - `ERC20Burnable` for redemption flows

#### Event Emission Pattern
Emit events for all compliance-critical operations:
```solidity
event KYCStatusChanged(address indexed user, bool status);
event TokensMinted(address indexed recipient, uint256 amount);
event TokensBurned(address indexed sender, uint256 amount);
```

#### Modifier Usage
Use modular decorators for reusable access control:
- `onlyOwner` - issuer/admin only functions
- Create custom modifiers like `onlyKYCVerified(address user)` for wallet-level checks

### Documentation Structure
- **README.md**: Landscape of blockchain tech (ZK, modular chains, RWA, AI+crypto)
- **Solidity.md**: Language fundamentals (gas, accounts, transactions, functions, modifiers, events)
- **workflow.md**: Step-by-step RWA demo construction with code scaffolds and scenario design
- **web3.md & website.md**: Supplementary ecosystem context

### External Dependencies & Integrations

#### OpenZeppelin Contracts
- Standard library for ERC20, Ownable, access control
- Location: `node_modules/@openzeppelin/contracts/`
- Use these instead of custom implementations

#### Scaffold-ETH 2 (Demo Toolkit)
- Auto-generates React frontend from contract ABIs
- Install after contract compilation: `npm create eth -- --scaffold` 
- Auto-discoverers contract functions and exposes them as UI buttons

#### Hardhat Ecosystem
- `hardhat.config.js`: Network config, compiler settings, plugin registration
- `scripts/`: Deployment and test scenario scripts
- `test/`: Jest or Mocha test files

## Key Files to Understand

| File | Purpose | Key Pattern |
|------|---------|-------------|
| `contracts/Sample.sol` | Main RWA token implementation | KYC + ERC20 override pattern |
| `workflow.md` | RWA demo blueprint with full scenario | Four-phase implementation roadmap |
| `Solidity.md` | Language reference with code examples | Explains modifiers, events, inheritance |
| `contracts/artifacts/` | Compiled ABIs and metadata | Use for frontend binding |

## Common AI Agent Tasks

### Adding New Compliance Features
When implementing features like `forceTransfer()`:
1. Add `require()` checks validating both addresses are KYC verified
2. Emit an event for audit trails
3. Test with both whitelist and non-whitelist scenarios
4. Document in `workflow.md` which demo step it affects

### Extending Token Standard
New functions should:
- Inherit from existing OpenZeppelin contracts, not replace them
- Override `_update()` for transfer logic (not `transfer()`)
- Use `super._update()` to call parent implementation

### Integration Testing
- Write Hardhat scripts simulating the full demo scenario
- Use signers for different user roles (issuer, users, admin)
- Verify KYC checks prevent unauthorized transfers
