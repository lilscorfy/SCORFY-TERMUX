#!/bin/bash

GITHUB_USER="lilscorfy"

echo -e "\e[1;32mChecking if you follow @$GITHUB_USER on GitHub...\e[0m"

# Ask for GitHub username
read -p "Enter your GitHub username: " USERNAME

if [[ "$USERNAME" == "lilscorfy" ]]; then
    echo -e "\e[1;32mYou are the owner! Skipping the check.\e[0m"
else
    # Proceed with the following check
    FOLLOWING=$(curl -s "https://api.github.com/users/$USERNAME/following" | jq -r ".[].login" | grep -w "lilscorfy")

    if [[ -z "$FOLLOWING" ]]; then
        echo -e "\e[1;31mYou are not following @lilscorfy on GitHub. Please follow and try again.\e[0m"
        exit 1
    fi

    echo -e "\e[1;32mVerified! You follow @lilscorfy. Installing SCORFY-Termux...\e[0m"
fi

# Update and install dependencies
pkg update -y && pkg upgrade -y
pkg install figlet nmap hydra -y

# Download and setup SCORFY
mkdir -p $PREFIX/bin
curl -o $PREFIX/bin/scorfy.sh https://raw.githubusercontent.com/lilscorfy/SCORFY-TERMUX/main/scorfy.sh
chmod +x $PREFIX/bin/scorfy.sh

# Create a command shortcut
echo "bash $PREFIX/bin/scorfy.sh" > $PREFIX/bin/scorfy
chmod +x $PREFIX/bin/scorfy

echo -e "\e[1;32mInstallation Complete! Run 'scorfy' to start.\e[0m" 