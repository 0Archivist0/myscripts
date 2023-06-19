#!/bin/bash

# Function to speak highlighted text
speak_highlighted_text() {
    local highlighted_text=$(xclip -o -selection primary)

    if [[ -n $highlighted_text ]]; then
        echo "$highlighted_text" | espeak
    else
        echo "No text is highlighted."
    fi
}

# Install prerequisites
sudo apt update
sudo apt install python3 python3-pip libsox-fmt-all xclip
pip3 install tensorflow==2.5.0 librosa==0.8.1 espeak

# Clone DeepSpeech repository and install DeepSpeech
git clone https://github.com/mozilla/DeepSpeech.git
cd DeepSpeech
pip3 install .

# Read user input for audio file path
read -p "Enter the path to the audio file you want to transcribe: " audio_file

# Transcribe audio file using DeepSpeech
transcription=$(deepspeech transcribe "$audio_file")

# Print the transcription
echo "Transcription: $transcription"

# Convert the transcription to speech using espeak
espeak "$transcription"

# Main program
while true; do
    read -p "Press Enter to speak the highlighted text (or 'q' to quit): " choice

    case $choice in
        q)
            echo "Exiting the script."
            break
            ;;
        *)
            speak_highlighted_text
            ;;
    esac
done
