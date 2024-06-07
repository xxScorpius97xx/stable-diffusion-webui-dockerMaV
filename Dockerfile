# Use the official Python 3.9 image
FROM python:3.9

# Update and install necessary packages
RUN DEBIAN_FRONTEND=noninteractive apt update && \
    apt install -y --no-install-recommends \
    tzdata wget git ffmpeg libsm6 libxext6 && \
    apt-get clean && \
    useradd -s /bin/bash -m fcb

# Clone the Stable Diffusion WebUI repository and checkout a specific commit
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
    cd stable-diffusion-webui && \
    git pull && \
    git fetch && \
    git checkout 4afaaf8a020c1df457bcf7250cb1c7f609699fa7 && \
    mkdir /stable-diffusion-webui/models/Lora

# Download the specific LoRA model
RUN wget https://civitai.com/api/download/models/511677 -O /stable-diffusion-webui/models/Lora/maveverclear.safetensors

# Copy the entry point script to the container
COPY entrypoint.sh /entrypoint.sh

# Set permissions for the entry point script
RUN chmod +x /entrypoint.sh

# Set the entry point for the container
ENTRYPOINT ["/entrypoint.sh"]
