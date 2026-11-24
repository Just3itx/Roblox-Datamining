-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GameDetails = require(script.GameDetails)
local GamesByPlaceId = require(script.GamesByPlaceId)
local GetGameNameAndDescription = require(script.GetGameNameAndDescription)
local FetchGamePlayabilityAndProductInfo = require(script.FetchGamePlayabilityAndProductInfo)
local FetchUserSettingsAndOptions = require(script.FetchUserSettingsAndOptions)
return {
    AgeRecommendations = require(script.AgeRecommendations),
    ExperienceDetails = require(script.ExperienceDetails),
    FetchGamePlayabilityAndProductInfo = FetchGamePlayabilityAndProductInfo,
    FetchUserSettingsAndOptions = FetchUserSettingsAndOptions,
    GameDetails = GameDetails,
    GamesByPlaceId = GamesByPlaceId,
    GetGameNameAndDescription = GetGameNameAndDescription,
    ["jest.config"] = script["jest.config"]
}
