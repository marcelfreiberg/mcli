#!/usr/bin/env python3

# Check dependencies
try:
    import os
    from simple_term_menu import TerminalMenu
except ModuleNotFoundError:
    print("Please install the dependencies by running the following command:")
    print("pip3 install -r requirements.txt")
    exit(1)


def create_pyenv():
    pass


def delete_pyenv():
    pass


def activate_pyenv():
    # Check if the pyenvs folder exists and create it if it doesn't
    pyenvs_folder = os.path.expanduser("~/.marcellocli/pyenvs")
    if not os.path.exists(pyenvs_folder):
        os.makedirs(pyenvs_folder)

    # Get a list of all folder in ~/.marcellocli/pyenvs
    pyenvs = os.listdir(pyenvs_folder)

    terminal_menu = TerminalMenu(pyenvs)

    menu_entry_index = terminal_menu.show()

    print("You selected: " + pyenvs[menu_entry_index])


def main():
    options = ["Create new Python environment",
               "Delete Python environment", "Activate Python environment"]
    terminal_menu = TerminalMenu(options)

    menu_entry_index = terminal_menu.show()

    print("You selected: " + options[menu_entry_index])

    if menu_entry_index == 0:
        create_pyenv()
    elif menu_entry_index == 1:
        delete_pyenv()
    elif menu_entry_index == 2:
        activate_pyenv()


if __name__ == "__main__":
    main()
