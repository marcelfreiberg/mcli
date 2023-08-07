import click


class PomodoroTimer:
    def __init__(
        self, work_duration=25, break_duration=5, long_break_duration=15, cycles=4
    ):
        self._work_duration = work_duration
        self._break_duration = break_duration
        self._long_break_duration = long_break_duration
        self._cycles = cycles

    def start(self):
        self._status = "started"
        print("Pomodoro timer started!")

    def stop(self):
        self._status = "stopped"
        print("Pomodoro timer stopped!")

    def pause(self):
        self._status = "paused"
        print("Pomodoro timer paused!")

    def status(self):
        print("Pomodoro timer status: {}".format(self._status))


@click.group(invoke_without_command=True)
@click.pass_context
def pomo(ctx):
    """Manage Pomodoro timer."""
    if ctx.invoked_subcommand is None:
        click.echo("test")
    pass


@pomo.command()
def start():
    """Start Pomodoro timer."""
    click.echo("Pomodoro timer started!")


@pomo.command()
def stop():
    """Stop Pomodoro timer."""
    click.echo("Pomodoro timer stopped!")


@pomo.command()
def status():
    """Show Pomodoro timer status."""
    click.echo("Pomodoro timer status!")


@pomo.command()
def pause():
    """Pause Pomodoro timer."""
    click.echo("Pomodoro timer paused!")
