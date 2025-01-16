#!/bin/bash

# Function to check if Ollama is running
check_ollama() {
    if ! pgrep -x "ollama" > /dev/null; then
        read -p "Ollama is not running. Do you want to start it? (Y/n): " start_ollama
        if [[ "$start_ollama" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            ollama &
            echo "Ollama started."
        else
            echo "Exiting..."
            exit 1
        fi
    fi
}

# Function to start a chat with llama 3.2
start_chat_llama() {
    echo "Starting chat with llama 3.2..."
    # Add your command to start chat with llama 3.2 here
}

# Function to stop all instances of local LLMs
stop_all_llms() {
    echo "Stopping all instances of local LLMs..."
    pkill -f "llama3.2"
    pkill -f "ollama"
    echo "All instances stopped."
}

# Function to stop an individual local LLM
stop_individual_llm() {
    read -p "Enter the name of the LLM to stop: " llm_name
    pkill -f "$llm_name"
    echo "$llm_name stopped."
}

# Function to view all instances of running local LLMs
view_running_llms() {
    echo "Viewing all instances of running local LLMs..."
    pgrep -fl "llama3.2"
    pgrep -fl "ollama"
}

# Function to view all installed local LLMs
view_installed_llms() {
    echo "Viewing all installed local LLMs..."
    # Assuming installed LLMs are listed in a specific directory
    ls ~/local-llms
}

# Function to view system usage and metrics
view_system_usage() {
    echo "Viewing system usage and metrics..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # MacOS specific command
        top -l 1 | head -n 10
    else
        # Linux specific command
        top -b -n 1 | head -n 10
    fi
}

# Function to start the UI server
start_ui_server() {
    echo "Starting the UI server..."
    cd ~/development/local-llm-web && pnpm run dev &
    sleep 2
    local port=$(lsof -i -P -n | grep LISTEN | grep :300 | awk '{print $9}' | cut -d: -f2 | head -n 1)
    if [ -z "$port" ]; then
        port=3000
    fi
    open "http://localhost:$port"
}

# Function to stop the UI server
stop_ui_server() {
    echo "Stopping the UI server..."
    pkill -f "pnpm run dev"
}

# Function to display the menu
show_menu() {
    echo -e "\033[1;32m1) Start a chat with llama 3.2\033[0m"
    echo -e "\033[1;32m2) Stop all instances of local LLMs\033[0m"
    echo -e "\033[1;32m3) Stop an individual local LLM\033[0m"
    echo -e "\033[1;32m4) View all instances of running local LLMs\033[0m"
    echo -e "\033[1;32m5) View all installed local LLMs\033[0m"
    echo -e "\033[1;32m6) View system usage and metrics\033[0m"
    echo -e "\033[1;32m7) Start the UI server\033[0m"
    echo -e "\033[1;32m8) Stop the UI server\033[0m"
    echo -e "\033[1;32m9) Exit\033[0m"
}

# Function to handle menu selection
handle_selection() {
    case $1 in
        1) start_chat_llama ;;
        2) stop_all_llms ;;
        3) stop_individual_llm ;;
        4) view_running_llms ;;
        5) view_installed_llms ;;
        6) view_system_usage ;;
        7) start_ui_server ;;
        8) stop_ui_server ;;
        9) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
}

# Main script execution
check_ollama

while true; do
    show_menu
    read -p "Select an option: " option
    handle_selection $option
done
