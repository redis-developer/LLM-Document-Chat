# Redis-LLM-Document-Chat

This repository provides the materials for the joint Redis/Microsoft blog post [here](https://techcommunity.microsoft.com/t5/azure-developer-community-blog/vector-similarity-search-with-azure-cache-for-redis-enterprise/ba-p/3822059). It contains a Jupyter notebook that demonstrates how to use Redis as a vector database to store and retrieve document vectors. The notebook also shows how to use LlamaIndex to perform semantic search for context within documents
and provide a chatbot-like experience using OpenAI.

https://user-images.githubusercontent.com/13009163/237002719-26e3118d-77ee-4ded-96f5-6ba801cae66c.mov


## Getting Started

The LLM Document Chat tutorial is **intended to run on a dockerized Jupyter lab environment** to ensure ideal experience and minimal Python environment hickups. At a minimum, you will need to install [Docker Desktop](https://www.docker.com/products/docker-desktop/) (*which comes with Docker Compose*) to run this example.

The project maintains a `.env.template` with the following variables pre-defined:

```bash
# General OpenAI Env Vars
OPENAI_TEXT_MODEL=gpt-35-turbo
OPENAI_EMBEDDING_MODEL=text-embedding-ada-002
OPENAI_TEMPERATURE=0.7
OPENAI_MAX_TOKENS=50

# OpenAI Direct Env Vars
OPENAI_API_KEY=<your key here>
OPENAI_API_BASE=https://api.openai.com/v1/

# Azure OpenAI Env Vars
#OPENAI_API_VERSION=2023-05-15 # use OPENAI_API_VERSION only with Azure OpenAI
AZURE_EMBED_MODEL_DEPLOYMENT_NAME=<your deployment name here>
AZURE_TEXT_MODEL_DEPLOYMENT_NAME=<your deployment name here>
AZURE_OPENAI_API_BASE=https://<your deployment name>.openai.azure.com/

# General Env Vars
CHUNK_SIZE=500
CHUNK_OVERLAP=0.2

# Redis Env Vars
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD=
```

Make a copy of this file to create `.env` as follows:
```bash
$ cp .env.template .env
```

Update portions of the env file based on your choices below:
1. **[Choose your OpenAI provider](#choose-your-openai-provider)**
2. **[Choose your Redis provider](#choose-your-redis-provider)**


---
**NOTE** If you are hosting this sample on Azure, you can quickly deploy Azure OpenAI and Azure Cache for Redis Enterprise instance with the right configurations by running the following commands:

```bash
az group create -n LLMDocChatRG -l eastus

az deployment group create --template-file infra\bicep\main.bicep -g LLMDocChatRG
```

To remove all Azure resources, simply delete the resource group using:
```bash
az group delete -n LLMDocChatRG

```

Alternately, you can choose to use OpenAI or other Redis providers as documented below.
---

### Choose your OpenAI provider
You can choose between **[Azure OpenAI Service](#to-use-azure-openai)** (fully hosted and managed by Azure) and **[OpenAI](#to-use-openai)** direct.


#### To Use Azure OpenAI (Recommended)
To use Azure OpenAI, you will need to follow these instructions

1. Create an Azure OpenAI resource.
2. Create model deployments for the text and embedding models.
4. Configure the ``.env`` file adding the specific values for your deployments.

```bash
AZURE_EMBED_MODEL_DEPLOYMENT_NAME=<your deployment name here>
AZURE_TEXT_MODEL_DEPLOYMENT_NAME=<your deployment name here>
AZURE_OPENAI_API_BASE=https://<your deployment name>.openai.azure.com/
```

#### To Use OpenAI

To use OpenAI, you will need to follow these instructions

1. Create an OpenAI account.
2. Create an OpenAI API key.
3. Configure the ``.env`` file adding the specific values for your deployments.

```bash
OPENAI_API_KEY=<your key here>
```


### Choose your Redis provider
The tutorial will require the usage of the Redis Search & Query features, including support for Vector Similarity Search. There are three options for running Redis:

1. [Redis Enterprise Cloud - Free Instance](https://redis.com/try-free)
2. Azure Redis Enterprise (ACRE)
3. Redis Stack (local docker)

For each, the following options are **required** and must be updated in your local `.env` file:

```bash
REDIS_PASSWORD=<your password here>
REDIS_HOST=<your redis host address here>
REDIS_PORT=<your redis port here>
```

There are some ``docker-compose.yml`` files in the ``docker`` directory that will help spin up
redis-stack locally and redisinsight in the case where a remote Redis is being used (like ACRE).

## Run

To open the jupyter environment through docker, follow these steps:

1. Clone this repository to your local machine.
2. Copy the ``.env.template`` to ``.env`` and configure the values as outlined above.
3. Run with Docker Compose:

    **For Cloud or Azure Redis Enterprise**
    ```bash
    docker compose -f docker/cloud/docker-compose.yml up
    ```

    **For Local (Docker) Redis Stack**
    ```bash
    docker compose -f docker/local/docker-compose.yml up
    ```
4. Open the Jupyter lab session in your browser at `http://127.0.0.1:8888/lab?token={YOUR GENERATED TOKEN}`. *Check the terminal logs for the token string.*