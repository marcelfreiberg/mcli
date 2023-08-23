import click


@click.group()
def test():
    """Test is a test command."""
    click.echo("test!")
    pass


@test.command()
def test1():
    """Test1 is a test command."""
    click.echo("test1!")
    pass


@test.command()
def test2():
    """Test2 is a test command."""
    click.echo("test2!")
    pass
