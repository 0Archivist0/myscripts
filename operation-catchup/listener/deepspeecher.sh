#!/bin/bash

# Install prerequisites
sudo apt update
sudo apt install python3 python3-pip libsox-fmt-all
pip3 install tensorflow==2.5.0 librosa==0.8.1

# Clone DeepSpeech repository and install DeepSpeech
git clone https://github.com/mozilla/DeepSpeech.git
cd DeepSpeech
pip3 install .

# Read user input for audio file path
read -p "Enter the path to the audio file you want to transcribe: " audio_file

# Transcribe audio file using DeepSpeech
deepspeech transcribe "$audio_file"
