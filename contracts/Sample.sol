// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleRWA is ERC20, Ownable {
    // 模拟现实世界资产：比如这是一个 "黄金代币"，1 Token = 1 Gram Gold
    string public assetBacking = "1 Gram Gold Bar #8888"; 
    
    // 白名单：只有被批准的地址才能持有
    mapping(address => bool) public isKYC;

    // 构造函数：初始化代币名称和符号
    constructor() ERC20("Gold RWA Demo", "GLD") Ownable(msg.sender) {}

    // --- 步骤 1: 合规入场 (KYC) ---
    function setKYC(address user, bool status) external onlyOwner {
        isKYC[user] = status;
    }

    // --- 步骤 2: 资产上链 (发行/Mint) ---
    // 只有管理员（发行方）在银行收到钱后，才能铸造
    function mint(address to, uint256 amount) external onlyOwner {
        require(isKYC[to], "User not KYC verified!");
        _mint(to, amount);
    }

    // --- 步骤 3: 强制销毁 (赎回/Redeem) ---
    // 用户把 Token 转回给管理员，管理员销毁 Token 并打款法币
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // --- 核心限制: 转账拦截 ---
    // RWA 的精髓：重写 update 函数，禁止未授权转账
    function _update(address from, address to, uint256 value) internal override {
        // 允许 Mint (from=0) 和 Burn (to=0)
        if (from != address(0) && to != address(0)) {
            require(isKYC[from] && isKYC[to], "Both parties must be KYC verified!");
        }
        super._update(from, to, value);
    }
}