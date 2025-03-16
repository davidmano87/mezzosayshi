# mezzosayshi
Mezzo says hi 👋

## Features

`mezzosayshi` gives a warm greeting from Mezzo, a lovely cat 🐈:

```console
$ mezzosayshi
Mezzo says hi 👋

$ mezzosayshi Maria
Mezzo says hi, Maria 👋
```

## For developer (WIP)

### Develop

```bash
uv pip install -r pyproject.toml # Install dependencies
uv run mezzosayshi               # Run application
uv add <package>                 # Add dependency
```

### Build binary

```bash
uv pip install -r pyproject.toml
# Workaround, see https://github.com/astral-sh/uv/issues/8590
uv export --only-group=build | uv pip install --requirements=-
uvx shiv -c mezzosayshi -o mezzosayshi -p '/usr/bin/env python3' .

# Optional: move the binary to a location added to PATH
mkdir -p ~/.local/bin
mv mezzosayshi ~/.local/bin
```

### Create new release of binaries

```bash
git tag <vX.Y.Z> -m "<reason>"
git push origin tag <vX.Y.Z>
```
