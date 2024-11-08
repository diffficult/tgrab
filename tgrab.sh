#!/bin/bash

# Function to show error messages in bold red on white background with error icon
show_error() {
    echo -e "\e[1;41;37m  $1\e[0m"  # Using
}

# Function to check if xclip is installed
check_xclip() {
    if ! command -v xclip >/dev/null 2>&1; then
        show_error "Error: xclip is not installed!"
        echo "󰏖 You can install it using:"  # Package icon
        echo "󰆍 sudo pacman -S xclip"      # Terminal icon
        exit 1
    fi
}

# Help message
show_help() {
    echo "󰘥 Usage: $(basename $0) [options]"    # Settings icon
    echo "Options:"
    echo "  -p NUMBER  Copy the NUMBERth previous command output (default: 1)"
    echo "  -h        Show this help message"
}

# Default values
previous=1       # Default to last output

# Parse command line options
while getopts "p:h" opt; do
    case $opt in
        p)
            previous=$OPTARG
            if ! [[ $previous =~ ^[0-9]+$ ]]; then
                show_error "Error: Previous value must be a number"
                exit 1
            fi
            ;;
        h)
            show_help
            exit 0
            ;;
        \?)
            show_error "Invalid option: -$OPTARG"
            show_help
            exit 1
            ;;
    esac
done

# Check for xclip first
check_xclip

# Capture the pane content with scrollback
tmux_content=$(tmux capture-pane -pJS-)

# Find all prompt lines
IFS=$'\n' prompt_positions=($(echo "$tmux_content" | grep -n "❯❯❯"))
total_prompts=${#prompt_positions[@]}

# Check if we have enough prompts for the requested previous count
if [[ $total_prompts -lt $((previous + 1)) ]]; then
    show_error "Not enough command outputs in buffer"
    echo -e "\e[0;31;47m 󰋔 Only found $((total_prompts - 1)) previous outputs\e[0m"  # Search icon
    exit 1
fi

# Get the relevant prompt positions based on the -p option
current_index=$((total_prompts - previous))
previous_index=$((current_index - 1))

current_prompt=$(echo "${prompt_positions[$current_index]}" | cut -d: -f1)
previous_prompt=$(echo "${prompt_positions[$previous_index]}" | cut -d: -f1)

# Extract text between prompts
start_line=$((previous_prompt + 1))
end_line=$((current_prompt - 2))

if [[ $start_line -le $end_line ]]; then
    # Extract the content
    output=$(echo "$tmux_content" | sed -n "${start_line},${end_line}p")

    # Check if output is empty
    if [[ -z "$output" ]]; then
        show_error "󰉘 Nothing to copy - no output found between prompts"  # Empty icon
        exit 1
    fi

    # Copy to clipboard
    echo "$output" | xclip -selection clipboard -i

    # Show feedback with clipboard icon
    echo "󰅌 Copied to clipboard"  # Clipboard icon
    # echo "$output" # uncomment if you want to also display what was copied to the clipboard
else
    show_error "󰉘 Nothing to copy - no output found between prompts"  # Empty icon
    exit 1
fi
