README
======

* Ref: 
  - chatgpt
  - <https://docs.vllm.ai/en/stable/>


### vLLM
* Overview
  - vLLM is a Python library for LLM inference and serving.
  - Originally developed in the Sky Computing Lab at UC Berkeley.

* NOTE:
  - You can run and test vLLM without a GPU, but with limited functionality and performance.
    - Installation and basic API setup
    - Starting the vllm engine with CPU-only mode
    - Running small models (like distilbert, tinyllama, etc.)
    - Debugging code or integrations (e.g., LangChain, OpenAI-compatible API)
  - Limitations:
    - Very slow inference – vLLM is optimized for GPU acceleration.
    - Large models (e.g., LLaMA-2, Mistral) may not run at all due to memory and compute limits.


### How to run:
* NOTE-250805:
  - I succeeded this test on Azure VM:
    - image: Ubuntu 22.04 
    - vmSize: `Standard_NC4as_T4_v3`
  - I failed this test on macOS

* Prerequisites:
  1. Create an Azure VM with GPU.
     - Use my template spec to create this VM.
  2. Install NVIDIA driver:
     ```
     sudo apt install -y nvidia-driver-535-server   # This is for Telsa T4
     # Please reboot the system; to verify, run nvidia-smi
     ``` 
  3. Install necessary python libraries:
     ```bash
     pip install vllm langchain
     ```

* Steps:
  1. Run server
     ```bash
     python3 -m vllm.entrypoints.openai.api_server \
       --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 \
       --dtype float32 \
     ```
  2. Run client
     ```bash
     python3 langchain-vllm.py
     ````


### Troubleshoot:
* Problem: no space left on device
  - Solution:
    ``` 
    docker system prune -a
    ```
