#!/usr/bin/env python3

import os
from simple_term_menu import TerminalMenu


def list_files(directory):
    files = os.listdir(directory)
    files = [file for file in files if os.path.isfile(
        os.path.join(directory, file))]
    return files


def cut_extensions(files):
    files = [file.split(".")[0] for file in files]
    return files


def execute_script(script):
    os.system("python3 ./scripts/" + script + ".py")


def execute_bash_script(script):
    os.system("./scripts/" + script + ".sh")


def main():
    options = list_files("./scripts")
    options = cut_extensions(options)

    terminal_menu = TerminalMenu(options)
    menu_entry_index = terminal_menu.show()

    print("You selected: " + options[menu_entry_index])
    execute_bash_script(options[menu_entry_index])


if __name__ == "__main__":
    main()
