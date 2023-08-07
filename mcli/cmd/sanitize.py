import click


@click.command()
@click.argument("files", nargs=-1, type=click.Path(exists=True))
def sanitize(files):
    """Sanitize path names."""
    click.echo("Sanitize path names.")
    click.echo("Files: {}".format(files))
