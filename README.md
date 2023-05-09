# Redis-LLM-Document-Chat

This repository provides the materials for the joint Redis/Microsoft blog post here (link to come). It contains a Jupyter notebook that demonstrates how to use Redis as a vector database to store and retrieve document vectors. The notebook also shows how to use LlamaIndex to perform semantic search for context within documents
and provide a chatbot-like experience using OpenAI.



https://user-images.githubusercontent.com/13009163/237002719-26e3118d-77ee-4ded-96f5-6ba801cae66c.mov


## Run

To run the script, follow these steps:

1. Clone this repository to your local machine.
2. Set the value of the `OPENAI_API_KEY` environment variable in ``docker-compose.yml``. This is required to access the OpenAI GPT models.
3. Run ``docker-compose up`` to start Redis as a vector database and Jupyter.
4. Navigate to ``http://localhost:8888/notebooks/redis-llm-doc-chat.ipynb`` and run the notebook.

