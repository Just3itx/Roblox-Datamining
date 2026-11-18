# Tracker icons and Discord emojis

Run `node scripts/generate-icons.mjs` (or `npm run icons`) to generate both PNG sets using `@resvg/resvg-js`:

- `assets/icons/<id>.png`: 256 × 256 Discord webhook avatars with a solid accent-color rounded square and a filled, pale-shaded voxel glyph.
- `assets/emoji/<id>.png`: 128 × 128 Discord custom emojis with a transparent background and the same filled glyph in lighter and darker shades of its accent color, with extra padding.

The glyphs use SVG shapes only: no fonts, outlines, gradients, or text.

| Tracker | Accent | Glyph | File |
| --- | --- | --- | --- |
| versions | `#00a2ff` | Rocket | `versions.png` |
| deploy-history | `#3b82f6` | Stacked shipping cubes | `deploy-history.png` |
| api-dump | `#22c55e` | Studded puzzle cube | `api-dump.png` |
| luau | `#a855f7` | Code block | `luau.png` |
| fflags | `#ef4444` | Flag on studded cube | `fflags.png` |
| games | `#f59e0b` | Game controller | `games.png` |
| catalog | `#ec4899` | Shopping bag with tag | `catalog.png` |
| limiteds | `#dc2626` | Faceted voxel gem | `limiteds.png` |
| watchlist | `#14b8a6` | Eye on studded cube | `watchlist.png` |
