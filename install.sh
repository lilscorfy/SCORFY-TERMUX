#!/bin/bash

GITHUB_USER="lilscorfy"

echo -e "\e[1;32mChecking if you follow @$GITHUB_USER on GitHub...\e[0m"

# Ask for GitHub username
read -p "Enter your GitHub username: " USERNAME

# Fetch user's following list and check if they follow you
FOLLOWING=$(curl -s "https://api.github.com/users/$USERNAME/following" | grep -o "\"login\": \"$GITHUB_USER\"")

if [[ -z "$FOLLOWING" ]]; then
    echo -e "\e[1;31mYou are not following @$GITHUB_USER on GitHub. Please follow and try again.\e[0m"
    exit 1
fi

echo -e "\e[1;32mVerified! You follow @$GITHUB_USER. Installing SCORFY-Termux...\e[0m"

# Update and install dependencies
pkg update -y && pkg upgrade -y
pkg install figlet nmap hydra -y

# Download and setup SCORFY
mkdir -p $PREFIX/bin
curl -o $PREFIX/bin/scorfy.sh https://raw.githubusercontent.com/lilscorfy/scorfy-termux/main/scorfy.sh
chmod +x $PREFIX/bin/scorfy.sh

# Create a command shortcut
echo "bash ~/scorfy.sh" > $PREFIX/bin/scorfy
chmod +x $PREFIX/bin/scorfy

echo -e "\e[1;32mInstallation Complete! Run 'scorfy' to start.\e[0m"
