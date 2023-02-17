#!/usr/bin/env python3

# Check dependencies
try:
    import os
    from simple_term_menu import TerminalMenu
except ModuleNotFoundError:
    print("Please install the dependencies by running the following command:")
    print("pip3 install -r requirements.txt")
    exit(1)


def list_files(directory: str) -> list:
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

    # Get all files in the directory
    files = os.listdir(directory)

    # Only keep files, not subdirectories
    files = [file for file in files if os.path.isfile(
        os.path.join(directory, file))]

    # Create a list of file information
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


def execute_script(file: dict) -> None:
    """Execute a script based on the file extension

    Parameters
    ----------
    file : dict
        A dict containing the file information
    """

    # Extract the file extension
    file_extension: str = file['file_extension']

    # Execute the script based on the file extension
    if file_extension == ".py":
        os.system("python3 " + file['file_path'])
    elif file_extension == ".sh":
        os.system("bash " + file['file_path'])
    else:
        print("File extension not supported")


def main():
    # Get a list of all the files in the scripts directory
    files = list_files("./scripts")

    # Get a list of the file names only
    options = [d['file_name'] for d in files]

    # Create a new TerminalMenu object
    terminal_menu = TerminalMenu(options)

    # Show the menu and get the index of the selected item
    menu_entry_index = terminal_menu.show()

    # Print which option the user selected
    print("You selected: " + options[menu_entry_index])

    # Run the script that the user selected
    execute_script(files[menu_entry_index])


if __name__ == "__main__":
    main()
