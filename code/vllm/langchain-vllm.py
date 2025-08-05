# 2025-07-02 08-05 knowpd


# Prerequisites:
#  1. Create an Azure VM with GPU.
#     - Use my template spec to create this VM.
#  2. Install NVIDIA driver:
#     ```
#     sudo apt install -y nvidia-driver-535-server   # This is for Telsa T4
#     # Please reboot the system; to verify, run nvidia-smi
#     ```
#  3. Install necessary python libraries:
#     ```bash
#     pip install vllm langchain
#     ```

# How to run:
#   1. Run server
#      ```
#      python3 -m vllm.entrypoints.openai.api_server \
#        --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 \
#        --dtype float32
#      ```
#   2. Run client
#      ```
#      python3 langchain-vllm.py
#      ````


from langchain_openai import ChatOpenAI
from langchain.schema import HumanMessage

llm = ChatOpenAI(
    openai_api_base="http://localhost:8000/v1",     # vLLM server
    openai_api_key="EMPTY",                         # vLLM doesn't require a key
    model="TinyLlama/TinyLlama-1.1B-Chat-v1.0"
)

response = llm.invoke([
    HumanMessage(content="What is LangChain?")
])

print(response.content)


# OUTPUT (sample):
#   LangChain is a real-time translation service created by Google Translate. 
#   It allows users to communicate in both languages through real-time text chat. 
#   LangChain differs from traditional translation tools as it provides live translation of text 
#   between multiple languages. It can be accessed via web browser and mobile applications, and 
#   it offers various options for voice and video calls using the Google Cloud Video Platform.
