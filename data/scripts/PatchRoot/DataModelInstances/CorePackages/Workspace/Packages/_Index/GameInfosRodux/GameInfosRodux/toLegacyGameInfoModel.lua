-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInfosRoduxParent = script:FindFirstAncestor("GameInfosRodux").Parent

local _DataHydration = require(GameInfosRoduxParent.DataHydration)
local _DiscoveryTypes = require(GameInfosRoduxParent.DiscoveryTypes)

local function toLegacyGameInfoModel(arg1)
    local creator = arg1.creator

    return {
        universeId = arg1.universeId,
        placeId = arg1.rootPlaceId,
        name = arg1.name,
        playerCount = arg1.playerCount,
        contentMaturity = arg1.contentMaturity,
        minimumAge = arg1.gameMinimumAge,
        ageRecommendationDisplayName = arg1.gameAgeDisplayName,
        creatorId = if creator then creator.id else nil,
        creatorName = if creator then creator.name else nil
    }
end

return toLegacyGameInfoModel
