# RWA(real world asset)

代币经济模型

合约 / 升级分叉

投票权 / 收益分享

uniswap

解决问题 / 共识


- 交易及清算

- 链上金融 Defi AAVE

## 预言机

报价中介

## 跨链

美国国债收益上链 / 托管 / 发行 


两链一桥

## 过捏

1. 联盟链 
2. DID 资产真实（充电桩）

## feature

权益凭证 / 派息合约 / 资产冻结

## DeFi 去中心化金融
CeFi vs DeFi

合约透明  

底链层 / 合约层 / 应用层


## 交易燃料 + 交易目标和消息 + 交易签名

助记词 ： 私钥  （1对多，派生）

区块链： 分布式数据库
状态数据库，智能合约（get / set）


 ## 以太坊

 L1 / L2


 ## 代币标准

 ERC20 

 ERC721

 ERC1155

## dapp架构

client 

server： 连接预言机（Chainlink, pyth），查询机构

ipfs： 存储
持久性问题：如果你不“钉住”文件，且无人存储，文件会从网络消失（需配合 Filecoin 等激励层实现长期存储）
性能：首次加载可能较慢，缺乏 CDN 加速
隐私：默认公开，敏感数据需额外加密
网关依赖：普通用户通常通过 ipfs.io/ipfs/Qm... 这类中心化网关访问，仍存在单点风险

Moralis 是一个面向 Web3 开发者的全栈开发平台，

QuickNode 是一个领先的 区块链基础设施即服务（Blockchain Infrastructure-as-a-Service）平台，为开发者提供高性能、高可用的 区块链节点访问、数据索引和开发工具，帮助 Web3 应用快速连接和交互各类区块链网络。

💡 简单说：QuickNode = 你通往区块链的“高速网关”

无需自己部署和维护复杂的节点服务器，直接通过 API 调用链上数据。

🔧 核心功能
1. 多链 RPC 节点接入
提供 20+ 主流区块链 的远程过程调用（RPC）端点，包括：
EVM 链：以太坊、Polygon、BNB Chain、Arbitrum、Optimism、Base、Avalanche 等
非 EVM 链：Solana、Bitcoin、Cosmos、Sui、Aptos、Stellar 等
支持 HTTP 和 WebSocket 连接，低延迟、高并发


智能合约不能自动触发 

DEX聚合器

Account Abstraction

MEV（矿工可提取价值）


攻击方式：

MEV 提取	❌ 否	高（普遍存在）	用户损失，非系统崩溃
交易审查	❌ 否	中（受监管驱动）	破坏去中心化精神
自私挖矿	⚠️ 边界	中（需 >33% 算力）	收益不稳定
双花攻击	✅ 是	低（主链极难）	高成本，高法律风险
空块/DoS	⚠️ 灰色	中	网络性能下降
