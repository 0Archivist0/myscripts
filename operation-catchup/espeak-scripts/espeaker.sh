 
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
