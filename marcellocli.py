#!/usr/bin/env python3

import os
from simple_term_menu import TerminalMenu


def list_files(directory) -> list:
    """List all files in a directory

    Parameters
    ----------
    directory : str
        The directory to list files from

    Returns
    -------
    list
        A list of files in the directory as a dict
    """

    files = os.listdir(directory)
    files = [file for file in files if os.path.isfile(
        os.path.join(directory, file))]

    table = []
    for file in files:
        file_name = os.path.splitext(file)[0]
        file_extension = os.path.splitext(file)[1]
        absolute_path = os.path.abspath(directory)
        file_path = os.path.join(absolute_path, file)

        table.append({'file': file,
                      'file_name': file_name,
                      'file_extension': file_extension,
                      'absolute_path': absolute_path,
                      'file_path': file_path})
    return table


def execute_script(file):
    """Execute a script based on the file extension

    Parameters
    ----------
    file : dict
        A dict containing the file information
    """

    match file['file_extension']:
        case ".py":
            os.system("python3" + file['file_path'])
        case ".sh":
            os.system(file['file_path'])
        case _:
            print("File extension not supported")


def main():
    files = list_files("./scripts")
    options = [d['file_name'] for d in files]

    terminal_menu = TerminalMenu(options)
    menu_entry_index = terminal_menu.show()

    print("You selected: " + options[menu_entry_index])

    execute_script(files[menu_entry_index])


if __name__ == "__main__":
    main()
