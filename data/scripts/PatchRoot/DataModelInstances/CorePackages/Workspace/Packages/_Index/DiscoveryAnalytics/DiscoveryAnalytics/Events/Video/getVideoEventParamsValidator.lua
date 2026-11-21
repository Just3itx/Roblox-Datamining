-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local DiscoveryTypes = require(DiscoveryAnalyticsParent.DiscoveryTypes)
local GameCollectionItemType = DiscoveryTypes.GameCollectionItemTypes.GameCollectionItemType
local OmniRecommendationsContentType = DiscoveryTypes.OmniRecommendationsContentType

local VideoEventInterfaceKey = require(script.Parent.VideoEventInterfaceKey)

local FFlagLuaAppEnableNxMRoduxApportioning = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning

local function getVideoEventParamsValidator(tbl1)
    if FFlagLuaAppEnableNxMRoduxApportioning and tbl1.tileType == GameCollectionItemType.OneByTwoTile then
        if tbl1.contentType == OmniRecommendationsContentType.AdLink then
            return VideoEventInterfaceKey.OneByTwoTileAdLink
        end

        return VideoEventInterfaceKey.OneByTwoTileGame
    end

    return VideoEventInterfaceKey.DefaultGameTile
end

return getVideoEventParamsValidator
