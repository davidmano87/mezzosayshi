import typer

app = typer.Typer()


@app.command()
def main(username: str = typer.Argument(None, envvar="MEZZOSAYSHI_USERNAME")):
    """Greeting from Mezzo."""
    print(f"Mezzo says hi{', ' + username if username else ''} 👋")


if __name__ == "__main__":
    app()
