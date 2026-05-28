[English](./README.md) | [中文](./README-ZH.md)

# OpenClaw A股量化分析工具包

一个基于 AI 的全栈式 A 股市场量化分析工具包。本项目集成了 **OpenClaw**（AI Agent 网关）、**LiteLLM**（多模型代理）以及一个专门的 **A股数据技能**，提供全面的研究环境。

## 🚀 概览

OpenClaw A股量化工具包专为资深量化分析师和 AI 研究人员设计。它提供了一个容器化的环境，允许用户通过自然语言和程序化工具与 A 股数据进行交互。

### 主要特性
- **全栈数据覆盖：** 7 层数据来源，包括实时行情（mootdx/腾讯/百度）、研报（东方财富/同花顺/问财）、资金流向、新闻及基本面数据。
- **AI Agent 网关：** 由 OpenClaw 驱动，支持复杂的多步推理和工具调用。
- **模型无关：** 借助 LiteLLM 代理，您可以使用任意 LLM（DeepSeek、GLM、GPT-4 等）作为推理引擎。
- **量化工具集：** 预置了 Python 环境，包含 `pandas`、`stockstats`、`mootdx` 和 `requests` 等库。

## 🏗️ 架构

本项目采用微服务架构，通过 Docker Compose 编排：

- **LiteLLM 代理：** 管理 API 密钥，并为多种 LLM 提供商提供统一的 OpenAI 兼容接口。
- **OpenClaw 服务：** 核心 Agent 宿主。它运行 `openclaw` 网关并承载 `a-stock-data` 技能。
- **技能：** 位于 `skills/` 目录下的专用工具集，用于扩展 Agent 的能力。

## 🛠️ 快速开始

### 前置条件
- Docker 和 Docker Compose
- 您所选择的 LLM 提供商的 API 密钥（例如 DeepSeek、GLM-4 等）
- （可选）用于语义搜索的 `IWENCAI_API_KEY`

### 安装步骤

1. **克隆代码仓库：**
   ```bash
   git clone https://github.com/your-repo/openclaw-astock
   cd openclaw-astock
   ```

2. **配置环境变量：**
   创建 `.env` 文件或导出以下变量：
   ```bash
   export LLM_API_KEY="your-llm-provider-api-key"
   export MODEL_NAME="your-preferred-model" # 例如 glm-4.7-flashx，免费版无效
   export LITELLM_MASTER_KEY="sk-stack-master-key"
   export IWENCAI_API_KEY="your-iwencai-key" # 可选
   ```

3. **启动服务栈：**
   ```bash
   chmod u+X *.sh
   ./restart.sh
   ```
   或手动执行：
   ```bash
   docker-compose up -d
   ```

### 验证安装
运行测试脚本以确保环境配置正确：
```bash
./test.sh
```

## 📂 项目结构

```text
.
├── docker-compose.yaml    # 服务编排文件
├── env.sh                 # 环境变量模板
├── restart.sh             # 重建并重启容器的辅助脚本
├── test.sh                # 基础连通性和配置测试脚本
├── litellm/               # LiteLLM 配置目录
│   └── config.yaml
├── openclaw/              # OpenClaw 服务配置及 Dockerfile
│   ├── Dockerfile
│   └── openclaw.json      # OpenClaw Agent 和模型设置
└── skills/                # Agent 技能目录
    └── a-stock-data/
        └── SKILL.md       # 全面的 A 股数据工具定义
```

## 📈 技能：a-stock-data

`a-stock-data` 技能是本项目的核心。它提供了覆盖 7 个层次的 28 个数据接口：

1. **行情层：** 实时报价、K 线、Level-2 数据（基于 mootdx、腾讯、百度）。
2. **研报层：** 研究报告检索及 PDF 下载。
3. **信号层：** 同花顺热门主题、北向资金、龙虎榜数据。
4. **资金层：** 融资融券、大宗交易、股东持股变动。
5. **新闻层：** 实时快讯及全球财经新闻。
6. **基本面层：** 财务报表（资产负债表、利润表、现金流量表）及 F10 资料。
7. **公告层：** 官方公司公告的全文检索（巨潮资讯网）。

## 使用示例
   ```bash
docker exec -it openclaw-service openclaw chat
请给我贵州茅台（600519）的当前价格和估值（PE/PB）。
   ```
