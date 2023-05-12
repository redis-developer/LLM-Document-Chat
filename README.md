# Redis-LLM-Document-Chat

This repository provides the materials for the joint Redis/Microsoft blog post here (link to come). It contains a Jupyter notebook that demonstrates how to use Redis as a vector database to store and retrieve document vectors. The notebook also shows how to use LlamaIndex to perform semantic search for context within documents
and provide a chatbot-like experience using OpenAI.

https://user-images.githubusercontent.com/13009163/237002719-26e3118d-77ee-4ded-96f5-6ba801cae66c.mov


## Setting up the Environment

The tutorial can run in multiple ways. The first step is to configure the ``.env`` file in this repository. This file contains the following variables:

```bash
OPENAI_TEXT_MODEL=text-davinci-003
OPENAI_DEPLOYMENT_TYPE=Text
OPENAI_EMBEDDING_MODEL=text-embedding-ada-002
OPENAI_EMBEDDINGS_ENGINE_QUERY=text-embedding-ada-002
OPENAI_API_KEY=<your key here>
OPENAI_TEMPERATURE=0.7
OPENAI_MAX_TOKENS=50
CHUNK_SIZE=500
CHUNK_OVERLAP=100
AZURE_EMBED_MODEL_DEPLOYMENT_NAME=<your deployment name here>
AZURE_TEXT_MODEL_DEPLOYMENT_NAME=<your deployment name here>
AZURE_OPENAI_API_BASE=https://<your deployment name>.openai.azure.com/
OPENAI_API_BASE=https://api.openai.com/v1/
REDIS_ADDRESS=localhost
REDIS_PORT=6379
REDIS_SSL=False
REDIS_PASSWORD=
```

### To Use Azure OpenAI

To use Azure OpenAI, you will need to follow these instructions

1. Create an Azure OpenAI resource
2. Create model deployments for the text and embedding models
4. Configure the ``.env`` file adding the specific values for your deployments

```bash
AZURE_EMBED_MODEL_DEPLOYMENT_NAME=<your deployment name here>
AZURE_TEXT_MODEL_DEPLOYMENT_NAME=<your deployment name here>
AZURE_OPENAI_API_BASE=https://<your deployment name>.openai.azure.com/
```

### To Use OpenAI

To use OpenAI, you will need to follow these instructions

1. Create an OpenAI account
2. Create an OpenAI API key
3. Configure the ``.env`` file adding the specific values for your deployments

```bash
OPENAI_API_KEY=<your key here>
```


### Azure Redis Enterprise, Redis Enterprise Cloud, and Redis Stack

The tutorial will require the usage of the Redis-stack contianer because of the use of RediSearch
and RedisJSON. There are three options for Redis

1. Redis Enterprise Cloud
2. Azure Redis Enterprise (ACRE)
3. Redis Stack (docker)
4. Redis Stack (local)

For each, the following options are required

```bash
# Azure Redis Enterprise requires SSL and a password so set
REDIS_SSL=True
REDIS_PASSWORD=<your password here>
REDIS_ADDRESS=<your redis address here>
REDIS_PORT=<your redis port here>
```

There are some ``docker-compose.yml`` files in the ``docker`` directory that will help spin up
redis-stack locally and redisinsight in the case where a remote Redis is being used (like ACRE).

### Run


To run the script, follow these steps:

1. Clone this repository to your local machine.
2. copy the ``.env.template`` to ``.env`` and configure the values as outlined above.
3. If using a local Python environment, just run the notebook
3. Otherwise, select a docker-compose file to run and execute ``docker-compose up`` to start the environment.
