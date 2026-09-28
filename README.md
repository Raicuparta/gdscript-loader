# gdscript-loader

Source for the [Godot](https://godotengine.org/) mod loader scripts used by
[Rai Pal](https://github.com/Raicuparta/rai-pal).

- `script-loader-3.gd` — loader for Godot 3 games
- `script-loader-4.gd` — loader for Godot 4 games

Each script scans a `mods` folder next to itself and loads every `.gd` file
found in its subfolders as a `Node`.

## Releases

The [release workflow](.github/workflows/release.yml) is triggered manually
(Actions → Release → Run workflow) with a release tag. It packages each script
into its own zip and publishes them as release assets:

- `godot-3.zip` (contains `script-loader.gd` for Godot 3)
- `godot-4.zip` (contains `script-loader.gd` for Godot 4)

Rai Pal downloads them from:

```text
https://github.com/Raicuparta/gdscript-loader/releases/download/<tag>/godot-<major>.zip
```
