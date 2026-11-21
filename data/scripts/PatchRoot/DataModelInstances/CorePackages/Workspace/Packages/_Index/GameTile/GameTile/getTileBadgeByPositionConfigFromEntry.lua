-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local _GameTileTypes = require(GameTile.GameTileTypes)

local function getTileBadgeByPositionConfigFromEntry(tbl1)
    if not (tbl1.badgePosition and tbl1.badgeAnalyticsId and tbl1.badgeType and (tbl1.badgeText or tbl1.badgeIcon)) then
        return nil
    end

    return {
        [tbl1.badgePosition] = {{
            analyticsId = tbl1.badgeAnalyticsId,
            tileBadgeType = tbl1.badgeType,
            text = tbl1.badgeText,
            icons = tbl1.badgeIcon and { tbl1.badgeIcon } or nil,
            tileBadgeComponentType = tbl1.badgeComponentType
        }}
    }
end

return getTileBadgeByPositionConfigFromEntry
