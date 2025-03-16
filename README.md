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

### Build binaries

```bash
uvx shiv -c mezzosayshi -o mezzosayshi -p '/usr/bin/env python3' .

mkdir -p ~/.local/bin
mv mezzosayshi ~/.local/bin
```

### Create new release of binaries

```bash
git tag <vX.Y.Z> -m "<reason>"
git push origin tag <vX.Y.Z>
```
