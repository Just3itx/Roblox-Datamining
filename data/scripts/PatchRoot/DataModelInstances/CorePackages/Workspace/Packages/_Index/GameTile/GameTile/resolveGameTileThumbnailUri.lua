-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")

local formatExperienceIcon = require(GameTile.formatExperienceIcon)
local formatExperienceThumbnail = require(GameTile.formatExperienceThumbnail)
local resolveWideAssetId = require(GameTile.resolveWideAssetId)

local function resolveGameTileThumbnailUri(tbl1)
    if tbl1.useGridTile then
        local var1 = resolveWideAssetId(tbl1.perEntryWideAssetId, tbl1.game, tbl1.topicId)

        if not (var1 or tbl1.placeId) then
            return nil
        end

        return formatExperienceThumbnail(var1, tbl1.placeId, tbl1.isEmphasized)
    elseif not tbl1.universeId then
        return tbl1.iconUrl
    else
        return formatExperienceIcon(tbl1.iconUrl, tbl1.universeId)
    end
end
return resolveGameTileThumbnailUri
