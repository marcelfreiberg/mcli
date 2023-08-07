import click


@click.command()
@click.option('--start', is_flag=True, help='Start the Pomodoro timer.')
def pomo(start):
    """Manage Pomodoro timer."""
    if start:
        click.echo('Pomodoro timer started!')
    else:
        click.echo('Use --start to begin the Pomodoro timer.')
