-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent

local GameTileConstants = require(GameTile.GameTileConstants)
local SharedFlags = require(GameTileParent.SharedFlags)
local TileOverflowMenuItems = GameTileConstants.TileOverflowMenuItems
local FFlagLuaAppContinueSortInstantPlay = SharedFlags.FFlagLuaAppContinueSortInstantPlay
local FFlagLuaAppEnableReportExperience = SharedFlags.FFlagLuaAppEnableReportExperience

local function getAvailableGameTileOverflowMenuItems(tbl1)
    local availableGameTileOverflowMenuItems = {}
    if tbl1.isSponsored then
        if tbl1.enableSponsoredFeedback then
            availableGameTileOverflowMenuItems[TileOverflowMenuItems.WhyThisAd] = true
        end
        if tbl1.enableReportAd then
            availableGameTileOverflowMenuItems[TileOverflowMenuItems.ReportAd] = true
        end
    end

    if tbl1.enableExplicitFeedback then
        availableGameTileOverflowMenuItems[TileOverflowMenuItems.NotInterested] = true
    end

    if FFlagLuaAppContinueSortInstantPlay and tbl1.enableGameDetails then
        availableGameTileOverflowMenuItems[TileOverflowMenuItems.GameDetails] = true
    end

    if FFlagLuaAppEnableReportExperience and tbl1.enableReportExperience and not tbl1.isSponsored then
        availableGameTileOverflowMenuItems[TileOverflowMenuItems.ReportExperience] = true
    end

    return availableGameTileOverflowMenuItems
end

return getAvailableGameTileOverflowMenuItems
