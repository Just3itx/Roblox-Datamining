# Tracker icons and Discord emojis

Run `node scripts/generate-icons.mjs` (or `npm run icons`) to generate both PNG sets using `@resvg/resvg-js`:

- `assets/icons/<id>.png`: 256 × 256 Discord webhook avatars with an accent-color rounded square and white SVG glyph.
- `assets/emoji/<id>.png`: 128 × 128 Discord custom emojis with a fully transparent background and the same glyph in its accent color. The emoji glyph has a thicker stroke and more padding for small display sizes.

| Tracker | Accent | Glyph | File |
| --- | --- | --- | --- |
| versions | `#00a2ff` | Rocket | `versions.png` |
| deploy-history | `#3b82f6` | Shipping package | `deploy-history.png` |
| api-dump | `#22c55e` | Puzzle piece | `api-dump.png` |
| luau | `#a855f7` | Scroll | `luau.png` |
| fflags | `#ef4444` | Flag | `fflags.png` |
| games | `#f59e0b` | Game controller | `games.png` |
| catalog | `#ec4899` | Shopping bag | `catalog.png` |
| limiteds | `#dc2626` | Gem | `limiteds.png` |
| watchlist | `#14b8a6` | Eye | `watchlist.png` |
