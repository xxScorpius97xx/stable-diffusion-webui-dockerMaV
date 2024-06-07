#!/bin/bash

# Navigate to the web UI directory
cd /stable-diffusion-webui

# Start the web UI with the defined command-line arguments
python launch.py --listen --port=9999 --enable-insecure-extension-access --api
