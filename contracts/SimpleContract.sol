// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleContract
 * @dev 极简的智能合约示例
 */
contract SimpleContract {
    // 状态变量
    uint256 public counter = 0;
    address public owner;

    // 事件
    event CounterIncremented(uint256 newValue);
    event CounterDecremented(uint256 newValue);

    // 构造函数
    constructor() {
        owner = msg.sender;
    }

    // 增加计数器
    function increment() public {
        counter += 1;
        emit CounterIncremented(counter);
    }

    // 减少计数器
    function decrement() public {
        if (counter > 0) {
            counter -= 1;
            emit CounterDecremented(counter);
        }
    }

    // 重置计数器 (仅所有者可调用)
    function reset() public {
        require(msg.sender == owner, "Only owner can reset");
        counter = 0;
    }

    // 查询当前计数值
    function getCounter() public view returns (uint256) {
        return counter;
    }
}
