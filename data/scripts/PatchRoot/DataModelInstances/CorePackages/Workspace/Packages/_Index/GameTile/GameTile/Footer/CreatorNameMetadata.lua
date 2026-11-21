-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local GameTileParent = GameTile.Parent
local GridTileTextFooter = require(GameTile.Footer.GridTileTextFooter)
local React = require(GameTileParent.React)
local useLocalization = require(GameTileParent.Localization).Hooks.useLocalization

local str1 = utf8.char(57344)

local function CreatorNameMetadata(tbl1)
    local creatorByLabel = useLocalization({ creatorByLabel = "Feature.GameDetails.Label.By" }).creatorByLabel

    local text = React.useMemo(function(): string
        if tbl1.name == nil or tbl1.name == "" then
            return ""
        end
        return `<b>{creatorByLabel} {tbl1.name}</b>{if tbl1.hasVerifiedBadge then str1 else ""}`
    end, { creatorByLabel, tbl1.name, tbl1.hasVerifiedBadge })

    return React.createElement(GridTileTextFooter, {
        LayoutOrder = tbl1.LayoutOrder,
        AnchorPoint = tbl1.AnchorPoint,
        Position = tbl1.Position,
        RichText = true,
        text = text,
        useLargerFont = true,
        isUnifiedGameTile = true
    })
end

return CreatorNameMetadata
