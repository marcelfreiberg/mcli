#!/bin/bash

set -u

INSTALL_DIR="$HOME/.marcellocli/bin"
MARCELLOCLI_DEFAULT_GIT_REMOTE="https://github.com/marcelfreiberg/1011_marcello-cli"

# Function to install the software
install_software() {
    echo "Installing Marcello CLI..."
    # Clone the GitHub repository containing the Marcello CLI
    git clone "$MARCELLOCLI_DEFAULT_GIT_REMOTE" "$INSTALL_DIR"
    
    # Add execute permission for the Python script
    chmod +x "$INSTALL_DIR/mcli.py"
    
    # Create a symbolic link in the bin directory to make it accessible from anywhere
    ln -s "$INSTALL_DIR/mcli.py" "$HOME/.local/bin/mcli"
    
    echo "Marcello CLI has been installed successfully."
    echo "You can now use 'mcli' command in your terminal."
}

# Check if the installation directory exists
if [[ -d "$INSTALL_DIR" ]]; then
    echo "Marcello CLI is already installed in $INSTALL_DIR."
    echo "If you want to reinstall, please run the uninstall script first."
    exit 1
fi

# Call the installation function
install_software

# Exit the script
exit 0
