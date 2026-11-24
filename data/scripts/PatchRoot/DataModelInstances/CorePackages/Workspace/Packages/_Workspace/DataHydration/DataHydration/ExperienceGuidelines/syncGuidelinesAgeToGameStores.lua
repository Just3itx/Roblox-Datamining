-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local getGameInfoStore = require(DataHydration.Game.GameInfo.getGameInfoStore)
local getAgeRecommendationStore = require(DataHydration.Game.AgeRecommendations.getAgeRecommendationStore)

local FFlagLuaAppDataHydrationUpdateItem = require(DataHydrationParent.SharedFlags).FFlagLuaAppDataHydrationUpdateItem

local _ExperienceGuidelinesStoreTypes = require(script.Parent.ExperienceGuidelinesStoreTypes)

return {
    syncGuidelinesAgeToGameStores = function(num1: number, arg1)
        local ageRecommendationDetails = arg1.ageRecommendationDetails
        local ageRecommendationSummary = ageRecommendationDetails and ageRecommendationDetails.ageRecommendationSummary
        local ageRecommendation = ageRecommendationSummary and ageRecommendationSummary.ageRecommendation
        if not ageRecommendation then
            return
        end

        local str1 = tostring(num1)

        if FFlagLuaAppDataHydrationUpdateItem then
            getGameInfoStore(false).updateGameInfo(str1, {
                gameMinimumAge = ageRecommendation.minimumAge,
                gameAgeDisplayName = ageRecommendation.displayName,
                contentMaturity = ageRecommendation.contentMaturity
            })
        end

        getAgeRecommendationStore(false).updateAgeRecommendations({
            [str1] = {
                displayName = ageRecommendation.displayName,
                displayNameWithHeaderShort = ageRecommendation.displayNameWithHeaderShort,
                igrsRating = ageRecommendation.igrsRating,
                igrsRatingDisplayMessage = ageRecommendation.igrsRatingDisplayMessage
            }
        })
    end
}
