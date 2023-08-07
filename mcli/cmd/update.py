import click


@click.group()
def update():
    """Test is a test command."""
    click.echo("test!")
    pass


@update.command()
def test1():
    """Test1 is a test command."""
    click.echo("test1!")
    pass


@update.command()
def test2():
    """Test2 is a test command."""
    click.echo("test2!")
    pass
