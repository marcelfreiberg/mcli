import click
import os

plugin_folder = os.path.join(os.path.dirname(__file__), "cmd")


class MyCLI(click.MultiCommand):
    def list_commands(self, ctx):
        commands = []

        for filename in os.listdir(plugin_folder):
            if filename.endswith(".py") and filename != "__init__.py":
                commands.append(filename[:-3])
            elif filename.endswith(".sh"):
                commands.append(filename[:-3])

        commands.sort()

        return commands

    def get_command(self, ctx, name):
        ns = {}
        fn = os.path.join(plugin_folder, name + ".py")

        with open(fn) as f:
            code = compile(f.read(), fn, "exec")
            eval(code, ns, ns)

        return ns[name]


@click.command(cls=MyCLI)
def cli():
    pass


if __name__ == "__main__":
    cli()
