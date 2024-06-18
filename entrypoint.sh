#!/bin/bash

# Download the file with a new filename and save it to the specified directory
wget https://civitai.com/api/download/models/395827 -O /stable-diffusion-webui/models/Stable-diffusion/mav_JibMixRealisticXL.safetensors &&

# Execute the web UI script
exec /stable-diffusion-webui/webui.sh
