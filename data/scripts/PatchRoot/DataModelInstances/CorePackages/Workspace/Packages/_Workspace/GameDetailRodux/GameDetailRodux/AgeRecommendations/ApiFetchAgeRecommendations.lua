-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailRodux = script:FindFirstAncestor("GameDetailRodux")
local GameDetailRoduxParent = GameDetailRodux.Parent

local Logging = require(GameDetailRoduxParent.AppCommonLib).Logging
local Promise = require(GameDetailRoduxParent.Promise)

local AgeRecommendationDetails = require(GameDetailRodux.AgeRecommendations.AgeRecommendationDetails)

local PerformFetch = require(GameDetailRoduxParent.Http).PerformFetch
local SetNetworkingErrorToast = require(GameDetailRoduxParent.RobloxAppToastsRodux).Thunks.SetNetworkingErrorToast
local SetAgeRecommendation = require(GameDetailRodux.AgeRecommendations.SetAgeRecommendation)
local SetAgeRecommendationHeaders = require(GameDetailRodux.AgeRecommendations.SetAgeRecommendationHeaders)
local GetAgeRecommendation = require(GameDetailRodux.AgeRecommendations.GetAgeRecommendation)

local module = {}

local function fetchKeymapper(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return "luaapp.experience_guidelines.get-age-guidelines" .. arg1
end

function module.Fetch(arg1, str1: string)
    return PerformFetch.Single(fetchKeymapper(str1), function(arg2)
        return GetAgeRecommendation(arg1, str1):andThen(function(arg3)
            local responseBody = arg3.responseBody
            if responseBody == nil then
                Logging.warn("Response from GetAgeRecommendation is malformed!")
                return Promise.reject({ HttpError = Enum.HttpError.OK })
            end

            local var1, var2 = AgeRecommendationDetails.fromJsonData(responseBody.ageRecommendationDetails):unwrap()

            if var1 == false then
                Logging.warn("Failed to parse AgeRecommendationDetails for `" .. str1 .. "`")
                return Promise.reject(arg3)
            end

            arg2:dispatch(SetAgeRecommendation(str1, var2))

            local headerDisplayName = responseBody.headerDisplayName
            local headerDisplayNameShort = responseBody.headerDisplayNameShort

            arg2:dispatch(SetAgeRecommendationHeaders(headerDisplayName, headerDisplayNameShort))

            return Promise.resolve(arg3)
        end, function(arg3)
            arg2:dispatch(SetNetworkingErrorToast(arg3))
            return Promise.reject(arg3)
        end)
    end)
end

function module.GetFetchingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (fetchKeymapper(arg2)))
end

return module
