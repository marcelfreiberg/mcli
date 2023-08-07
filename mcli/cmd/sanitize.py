import click
import os
import re


@click.command()
@click.argument("files", nargs=-1, type=click.Path(exists=True))
def sanitize(files):
    """Sanitize path names."""
    substitutions = [
        (r"ä", "ae"),
        (r"ö", "oe"),
        (r"ü", "ue"),
        (r"ß", "ss"),
        (r"[^a-zA-Z0-9_. -]", "_"),
        (r" ", "_"),
    ]

    for file in files:
        sanitized = file
        for pattern, replacement in substitutions:
            sanitized = re.sub(pattern, replacement, sanitized)

        if sanitized != file:
            click.echo(f"{file} -> {sanitized}")
            os.rename(file, sanitized)
