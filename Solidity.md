# 入门智能合约基础知识

## 区块链基础

- 交易/事务

区块链是全球共享的事务性数据库，这意味着每个人都可加入网络来阅读数据库中的记录。 如果您想改变数据库中的某些东西，您必须创建一个被所有其他人所接受的事务。 事务一词意味着您想做的（假设您想要同时更改两个值），要么一点没做，要么全部完成。 此外，当您的事务被应用到数据库时，其他事务不能修改数据库。

- 区块

交易会被捆绑成所谓的“区块”，然后它们将在所有参与节点中执行和分，这些区块按时间顺序形成线性序列

- 账户

在以太坊有两种共享同一地址空间的账户： 外部账户，由公钥-私钥对（也就是人）控制； 合约账户，由与账户一起存储的代码控制。

外部账户的地址是由公钥确定的， 而合约的地址是在合约创建时确定的 （它是由创建者地址和从该地址发出的交易数量得出的，即所谓的 “nonce”）

此外，每个账户有一个以太 余额 （ balance ）（单位是“wei”， 1 ether 是 10**18 wei）， 余额会因为发送包含以太币的交易而改变。

- 交易

有地址 / 创建新 合约

- GAS

燃料价格（gas price） 是交易发起人设定的值， 他必须提前向EVM执行器支付 燃料单价 * 燃料数量。 如果执行后还剩下一些燃料，则退还给交易发起人。 如果发生撤销更改的异常，已经使用的燃料不会退还。

- 存储，内存和栈

- 指令集

- 消息调用
合约可以通过消息调用的方式来调用其它合约或者发送以太币到非合约账户。 消息调用和交易非常类似，它们都有一个源，目标，数据，以太币，


## 合约示例


## 语言介绍


- 创建合约：

在内部，构造函数参数在合约代码之后通过 ABI编码 传递， 但是如果您使用 web3.js 则不必关心这个问题。

keccak256("functionName(type1,type2,...)")[0:4]

为什么 ABI 编码重要？
是 DApp 与智能合约通信的通用语言
保证不同语言/平台对 calldata 的理解一致
避免因编码错误导致交易失败或资金损失

创建合约一定需要知道另一个合约的源代码，所以不存在循环创建
publick / indternal / private

- 函数调用

external
外部函数作为合约接口的一部分，意味着我们可以从其他合约和交易中调用。 一个外部函数 f 不能从内部调用 （即 f() 不起作用，但 this.f() 可以）。

public
公开函数是合约接口的一部分，可以在内部或通过消息调用。

internal
内部函数只能从当前的合约或从它派生出来的合约中访问。 它们不能被外部访问。 由于它们没有通过合约的ABI暴露在外部，它们可以接受内部类型的参数，如映射或存储引用。

private
私有函数和内部函数一样，但它们在派生合约中是不可见的。


- Getter 函数

- 装饰器

- 对于 constant 变量，其值必须在编译时固定， 而对于 immutable 变量，仍然可以在构造时分

- 函数 return demo

```code
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract Simple {
    function arithmetic(uint a, uint b)
        public
        pure
        returns (uint sum, uint product)
    {
        sum = a + b;
        product = a * b;
    }
}
```

- View 函数
函数可以被声明为 view，在这种情况下，它们承诺不修改状态。

修改状态变量。

产生事件。

创建其它合约。

使用 selfdestruct。

通过调用发送以太币。

调用任何没有标记为 view 或者 pure 的函数。

使用低级调用。

使用包含特定操作码的内联汇编。


- Pure 函数
函数可以被声明为 pure，在这种情况下，它们承诺不读取或修改状态。 特别是，应该可以在编译时评估一个 pure 函数，只给它的输入和 msg.data， 但不知道当前区块链状态。这意味着读取 immutable 的变量可以是一个非标准pure的操作。

- 特殊函数

接收以太的函数
一个合约最多可以有一个 receive 函数， 使用 receive() external payable { ... } 来声明。（没有 function 关键字）。 这个函数不能有参数，不能返回任何东西，必须具有 external 的可见性和 payable 的状态可变性。 它可以是虚拟的，可以重写，也可以有修饰器。

- 一个比较复杂的Demo

```code
contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender; // 部署者自动成为 owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _; // 占位符，表示“被修饰的函数代码在这里执行”
    }
}
// 作用：提供一个通用的“仅所有者可操作”权限模型。
// modifier onlyOwner 是一个可复用的权限检查模板。
// 任何使用 onlyOwner 的函数，都会在执行前检查调用者是否是 owner。
```

```code
// 表示 Game 继承了 Ownable，自动获得 owner 变量和 onlyOwner 修饰器
contract Game is Ownable {
    uint public prize = 1000;

    // 允许子合约重写此函数
    // 应用权限控制：只有部署者（owner）能提现
    function withdrawPrize() public virtual onlyOwner {
        // 将 prize 金额的 ETH 转给调用者
        payable(msg.sender).transfer(prize);
    }
}
```

```code
contract EnhancedGame is Game {
    // override 明确表示这是对父类 withdrawPrize 的重写
    function withdrawPrize() public override onlyOwner {
        require(prize > 0, "No prize left");
        emit PrizeWithdrawn(msg.sender, prize);
        payable(msg.sender).transfer(prize);
        prize = 0; // 👈 关键修复：防止重复提现
    }

    event PrizeWithdrawn(address user, uint amount);
}
```

- 事件类型

什么是事件（Event）？
事件是 EVM 提供的一种日志机制。
当合约执行到 emit 语句时，会将结构化数据写入交易回执（transaction receipt）的日志（logs）中。
事件不会存储在合约状态中，也不会消耗大量 gas（比写 storage 便宜得多）。
前端（DApp）可以通过订阅事件来监听链上行为（如“某人铸造了 NFT”）。

Event（事件） ✅ 是（通过日志） 💰 低 ✅（indexed 字段） ✅（随区块永久存储） return 返回值

❌ 否（只在交易回执中，但不结构化） - ❌ ❌（不存链上） 写入 storage

✅ 是（但需主动查询） 💸 高 ❌（需遍历或额外索引） ✅

✅ 用于通知 DApp 前端（如“转账成功”“NFT 铸造”）
✅ 用于构建去中心化索引（如 The Graph 项目全靠事件）
✅ 是 Web3 用户体验（如 Metamask 弹出通知）的技术基础


- 接口合约

接口（interface）合约
接口（interface）合约类似于抽象（abstract）合约，但是它们不能实现任何函数。并且还有进一步的限制：

它们不能继承其他合约，但是它们可以继承其他接口合约。

在接口合约中所有声明的函数必须是 external 类型的，即使它们在合约中是 public 类型的。

它们不能声明构造函数。

它们不能声明状态变量。

它们不能声明修饰器。