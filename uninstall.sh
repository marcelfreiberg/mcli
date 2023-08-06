# #!/bin/bash

# # Set the installation directory
# INSTALL_DIR="/usr/local/mcli"

# # Function to uninstall the software
# uninstall_software() {
#     echo "Uninstalling Marcello CLI..."
#     # Remove the installation directory and all its contents
#     rm -rf "$INSTALL_DIR"
    
#     # Remove the symbolic link from the bin directory
#     rm -f "$HOME/.local/bin/mcli"

#     echo "Marcello CLI has been uninstalled successfully."
# }

# # Check if the installation directory exists
# if [[ ! -d "$INSTALL_DIR" ]]; then
#     echo "Marcello CLI is not installed on this system."
#     exit 1
# fi

# # Call the uninstallation function
# uninstall_software

# # Exit the script
# exit 0
