// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 引入 OpenZeppelin 的 ERC20 标准库
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    // 构造函数：在部署时运行一次
    // "MyTestToken" 是代币全称
    // "MTT" 是代币符号（你可以自己改，比如 BTC, ETH 这种）
    constructor() ERC20("MyTestToken", "MTT") {
        // 铸造 100万个代币给自己
        // 10 ** decimals() 是为了处理精度（通常是18位小数）
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}