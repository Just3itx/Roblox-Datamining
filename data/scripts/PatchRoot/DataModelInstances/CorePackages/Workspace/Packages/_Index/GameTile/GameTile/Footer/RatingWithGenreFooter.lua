-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GridTileIconTextFooter = require(GameTile.Footer.GridTileIconTextFooter)
local getGameStatsRatingPercentageText = require(GameTile.Footer.getGameStatsRatingPercentageText)

local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)
local iconsStatusGamesRating_small = require(GameTileParent.UIBlox).App.ImageSet.Images["icons/status/games/rating_small"]

return React.memo(function(tbl1) -- name: RatingWithGenreFooter
    local var1 = getGameStatsRatingPercentageText(tbl1.totalUpVotes, tbl1.totalDownVotes) .. "%"

    return React.createElement(GridTileIconTextFooter, {
        Position = tbl1.Position,
        icon = iconsStatusGamesRating_small,
        text = `{var1} \226\128\162 {tbl1.genreText}`,
        useLargerFont = tbl1.useLargerFont,
        isUnifiedGameTile = tbl1.isUnifiedGameTile
    })
end)
