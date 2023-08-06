import os
import argparse

def main():
    script_path = os.path.dirname(os.path.realpath(__file__))
    python_path = os.path.normpath(os.path.join(script_path, '../.venv/bin/python3'))

    parser = argparse.ArgumentParser(description='marcello-cli')

    subparsers = parser.add_subparsers(dest='command', help='Sub-commands')
    update = subparsers.add_parser('update', help='Update the mcli')
    menu = subparsers.add_parser('menu', help='Show the menu')

    args = parser.parse_args()

    if args.command == 'update':
        print('Updating...')
    elif args.command == 'menu':
        os.system(python_path + " " + os.path.normpath(os.path.join(script_path, './menu.py')))
    else:
        os.system(python_path + " " + os.path.normpath(os.path.join(script_path, './menu.py')))


if __name__ == '__main__':
    main()
