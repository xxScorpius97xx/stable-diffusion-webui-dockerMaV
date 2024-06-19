#!/bin/bash

# Download the file with a new filename and save it to the specified directory
wget https://civitai.com/api/download/models/507858?token=78d48788f784a570b5c1722fd3705756 -O /stable-diffusion-webui/models/Stable-diffusion/mav_CyberRealistic.safetensors &&
# Execute the web UI script
exec /stable-diffusion-webui/webui.sh
