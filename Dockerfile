FROM python:3.9

RUN DEBIAN_FRONTEND=noninteractive && apt update && apt install tzdata wget git ffmpeg libsm6 libxext6 -y && apt-get clean && useradd -s /bin/bash -m  fcb 

#RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && mkdir /stable-diffusion-webui/models/Lora
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && cd stable-diffusion-webui && git pull && git fetch && git checkout 4afaaf8a020c1df457bcf7250cb1c7f609699fa7 && mkdir /stable-diffusion-webui/models/Lora

ADD entrypoint.sh /stable-diffusion-webui

##################################### Add your LoRA models here ###########################################
### Add your LoRA models here, 
### You need to replace the <model_download_link> and <your_model_name>, then add the command to the below
### Command example: 
###                             RUN wget <model_download_link> -O /stable-diffusion-webui/models/Lora/<your_model_name>

ARG TOKEN
RUN wget https://civitai.com/api/download/models/511677?token=$TOKEN -O /stable-diffusion-webui/models/Lora/maveverclear.safetensors
RUN wget https://civitai.com/api/download/models/539667?token=$TOKEN -O /stable-diffusion-webui/models/Lora/mavslider.safetensors

#######################################################################################################
RUN chmod 777 -R stable-diffusion-webui /home/fcb && chown -R fcb:fcb stable-diffusion-webui
USER fcb

WORKDIR /stable-diffusion-webui

ENV COMMANDLINE_ARGS="--listen --port=9999 --enable-insecure-extension-access --api"

EXPOSE 9999

ENTRYPOINT ["bash", "entrypoint.sh"]
