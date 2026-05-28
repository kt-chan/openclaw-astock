[English](./README.md) | [中文](./README-ZH.md)

# OpenClaw A-Stock

An AI-powered full-stack quantitative analysis toolkit for the A-share (Chinese Stock Market) market. This project integrates **OpenClaw** (an AI agent gateway) with **LiteLLM** (a multi-model proxy) and a specialized **A-stock data skill** to provide a comprehensive research environment.

## 🚀 Overview

OpenClaw A-Stock is designed for senior quantitative analysts and AI researchers. It provides a containerized environment to interact with A-share data through natural language and programmatic tools.

### Key Features
- **Full-Stack Data Coverage:** 7 layers of data sources including real-time market quotes (mootdx/Tencent/Baidu), research reports (Eastmoney/THS/iWencai), capital flow, news, and fundamental data.
- **AI Agent Gateway:** Powered by OpenClaw, allowing for complex multi-step reasoning and tool execution.
- **Model Agnostic:** LiteLLM proxy allows you to use any LLM (DeepSeek, GLM, GPT-4, etc.) as the reasoning engine.
- **Quantitative Tooling:** Pre-installed Python environment with `pandas`, `stockstats`, `mootdx`, and `requests`.

## 🏗️ Architecture

The project uses a microservice architecture orchestrated by Docker Compose:

- **LiteLLM Proxy:** Manages API keys and provides a unified OpenAI-compatible endpoint for various LLM providers.
- **OpenClaw Service:** The core agent host. It runs the `openclaw` gateway and hosts the `a-stock-data` skill.
- **Skills:** Specialized toolsets (in `skills/`) that extend the agent's capabilities.

## 🛠️ Getting Started

### Prerequisites
- Docker and Docker Compose
- An API key for your preferred LLM provider (e.g., DeepSeek, GLM-4, etc.)
- (Optional) `IWENCAI_API_KEY` for semantic search capabilities.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/kt-chan/openclaw-astock.git
   cd openclaw-astock
   ```

2. **Configure Environment Variables:**
   Create a `.env` file or export the following variables:
   ```bash
   export LLM_API_KEY="your-llm-provider-api-key"
   export MODEL_NAME="your-preferred-model" # e.g., glm-4.7-flashx, free version do NOT work
   export LITELLM_MASTER_KEY="sk-stack-master-key"
   export IWENCAI_API_KEY="your-iwencai-key" # Optional
   ```

3. **Start the Stack:**
   ```bash
   chmod u+X *.sh
   ./restart.sh
   ```
   Or manually:
   ```bash
   docker-compose up -d
   ```

### Verification
Run the test script to ensure the environment is correctly set up:
```bash
./test.sh
```

## 📂 Project Structure

```text
.
├── docker-compose.yaml    # Service orchestration
├── env.sh                 # Environment variable templates
├── restart.sh             # Utility script to rebuild and restart containers
├── test.sh                # Basic connectivity and setup test
├── litellm/               # LiteLLM configuration
│   └── config.yaml
├── openclaw/              # OpenClaw service configuration and Dockerfile
│   ├── Dockerfile
│   └── openclaw.json      # OpenClaw agent and model settings
└── skills/                # Agent skills
    └── a-stock-data/
        └── SKILL.md       # Comprehensive A-share data tool definitions
```

## 📈 Skills: a-stock-data

The `a-stock-data` skill is the heart of this project. It provides 28 endpoints across 7 layers:
1. **Market Layer:** Real-time quotes, K-lines, and level-2 data (mootdx, Tencent, Baidu).
2. **Report Layer:** Research report retrieval and PDF downloading.
3. **Signal Layer:** THS hot topics, Northbound funds, and dragon-tiger boards.
4. **Capital Flow:** Margin trading, block trades, and shareholder changes.
5. **News Layer:** Real-time telegraphs and global financial news.
6. **Fundamental Layer:** Financial statements (Balance Sheet, P&L, Cash Flow) and F10 data.
7. **Announcement Layer:** Full-text search for official company announcements (Cninfo).

# Exmaple use
```bash
docker exec -it openclaw-service openclaw chat
Give me the current price and valuation (PE/PB) for Kweichow Moutai (600519).
```
