FROM python:3.9

# Set up necessary packages and user
RUN DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install tzdata wget git ffmpeg libsm6 libxext6 -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -s /bin/bash -m fcb

# Clone the specific commit of the repository and set up directories
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
    cd stable-diffusion-webui && \
    git pull && \
    git fetch && \
    git checkout 4afaaf8a020c1df457bcf7250cb1c7f609699fa7 && \
    mkdir -p /stable-diffusion-webui/models/Lora

# Add entrypoint script
ADD entrypoint.sh /stable-diffusion-webui

# Download model file
RUN wget https://civitai.com/api/download/models/511677 -O /stable-diffusion-webui/models/Lora/maveverclear.safetensors

# Set permissions and switch user
RUN chmod 777 -R /stable-diffusion-webui /home/fcb && \
    chown -R fcb:fcb /stable-diffusion-webui

USER fcb
WORKDIR /stable-diffusion-webui

# Define environment variables
ENV COMMANDLINE_ARGS="--listen --port=9999 --enable-insecure-extension-access --api"

# Expose port and set entrypoint
EXPOSE 9999
ENTRYPOINT ["bash", "entrypoint.sh"]
