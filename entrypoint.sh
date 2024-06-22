#!/bin/bash

# Download the file with a new filename and save it to the specified directory
wget https://civitai.com/api/download/models/293240 -O /stable-diffusion-webui/models/Stable-diffusion/mav_RealismEngineSDXL.safetensors &&
#Jib Mix Realistic XL V10 Lightning 4-6 Step
# Execute the web UI script
exec /stable-diffusion-webui/webui.sh
