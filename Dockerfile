FROM python:3.9

RUN DEBIAN_FRONTEND=noninteractive && apt update && apt install tzdata wget git ffmpeg libsm6 libxext6 -y && apt-get clean && useradd -s /bin/bash -m  fcb 

#RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && mkdir /stable-diffusion-webui/models/Lora
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && cd stable-diffusion-webui && git pull && git fetch && git checkout 4afaaf8a020c1df457bcf7250cb1c7f609699fa7 && mkdir /stable-diffusion-webui/models/Lora

ADD entrypoint.sh /stable-diffusion-webui

RUN wget https://civitai.com/api/download/models/511677 -O /stable-diffusion-webui/models/Lora/maveverclear.safetensors


#######################################################################################################
RUN chmod 777 -R stable-diffusion-webui /home/fcb && chown -R fcb:fcb stable-diffusion-webui
USER fcb

WORKDIR /stable-diffusion-webui

ENV COMMANDLINE_ARGS="--listen --port=9999 --enable-insecure-extension-access --api"

EXPOSE 9999

ENTRYPOINT ["bash", "entrypoint.sh"]
