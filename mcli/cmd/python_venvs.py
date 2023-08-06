# Check dependencies
import os
import subprocess
from simple_term_menu import TerminalMenu

def create_venv(venvs_folder: str):
    # Get venv name as input from the user
    venv_name = input("Enter the name of the Python virtual environment: ")

    # Check if the venv name is valid
    if not venv_name.isidentifier():
        print("The name of the Python virtual environment is invalid")
        exit(1)

    # Check if the venv already exists
    if os.path.exists(os.path.join(venvs_folder, venv_name)):
        print("The Python virtual environment already exists")
        exit(1)

    # Create a new Python vitual environment
    os.system("python3 -m venv " + os.path.join(venvs_folder, venv_name))


def delete_venv(venvs_folder: str):
    # Get a list of all available Python virtual environments
    venvs = os.listdir(venvs_folder)

    # If there are no Python virtual environments, exit
    if len(venvs) == 0:
        print("No Python virtual environments found")
        exit(0)

    # Create a terminal menu
    terminal_menu = TerminalMenu(venvs,
                                 title="Python virtual environments",
                                 clear_screen=True)

    menu_entry_index = terminal_menu.show()

    # Delete a Python virtual environment
    os.system("rm -rf " + os.path.join(venvs_folder, venvs[menu_entry_index]))


def activate_venv(venvs_folder: str):
    # Get a list of all available Python virtual environments
    venvs = os.listdir(venvs_folder)

    # If there are no Python virtual environments, exit
    if len(venvs) == 0:
        print("No Python virtual environments found")
        exit(0)

    # Create a terminal menu
    terminal_menu = TerminalMenu(venvs,
                                 title="Python virtual environments",
                                 clear_screen=True)

    menu_entry_index = terminal_menu.show()

    command = "source " + os.path.join(venvs_folder,
                                       venvs[menu_entry_index],
                                       "bin/activate")

    # Activate a Python virtual environment
    # os.system(command)

    print(command)

    # Copy the activate script to the clipboard
    subprocess.run("pbcopy", text=True, input=command)


def main():
    # Check if the pyenvs folder exists and create it if it doesn't
    venvs_folder = os.path.expanduser("~/.marcellocli/venvs")

    if not os.path.exists(venvs_folder):
        os.makedirs(venvs_folder)

    # Create a list of menu entries
    menu_entries = [
        {"text": "Activate Python environment", "function": activate_venv},
        {"text": "Create new Python environment", "function": create_venv},
        {"text": "Delete Python environment", "function": delete_venv},
    ]

    # Create a list of menu entry texts
    menu_entry_texts = [menu_entry["text"] for menu_entry in menu_entries]

    # Create a terminal menu
    terminal_menu = TerminalMenu(menu_entry_texts,
                                 title="Python virtual environments",
                                 clear_screen=True)

    menu_entry_index = terminal_menu.show()

    # Call the function of the selected menu entry
    menu_entries[menu_entry_index]["function"](venvs_folder)


if __name__ == "__main__":
    main()
