-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialExperienceJoin = script:FindFirstAncestor("SocialExperienceJoin")
local SocialExperienceJoinParent = SocialExperienceJoin.Parent

local GameDetailRodux = require(SocialExperienceJoinParent.GameDetailRodux)
local React = require(SocialExperienceJoinParent.React)
local RoactServiceTags = require(SocialExperienceJoinParent.RoactServiceTags)
local RoactUtils = require(SocialExperienceJoinParent.RoactUtils)
local RobloxAppHooks = require(SocialExperienceJoinParent.RobloxAppHooks)
local SignalsReact = require(SocialExperienceJoinParent.SignalsReact)

local NetworkingGames = require(SocialExperienceJoin.Networking.NetworkingGames)
local JoinCardCacheStore = require(SocialExperienceJoin.Stores.JoinCardCacheStore)

local PlayabilityStatusEnum = require(SocialExperienceJoinParent.DiscoveryTypes).PlayabilityStatusEnum

local FetchUserSettingsAndOptions = GameDetailRodux.FetchUserSettingsAndOptions
local ApiFetchAgeRecommendations = GameDetailRodux.AgeRecommendations.ApiFetchAgeRecommendations

local RoactNetworking = RoactServiceTags.RoactNetworking
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useRoactService = RobloxAppHooks.useRoactService
local useSignalState = SignalsReact.useSignalState

local FFlagLuaAppPlayButtonAmpAgeCheckFlow = require(SocialExperienceJoinParent.SharedFlags).FFlagLuaAppPlayButtonAmpAgeCheckFlow
local FFlagLuaAppPlayButtonWizardCloseDelay = require(SocialExperienceJoinParent.SharedFlags).FFlagLuaAppPlayButtonWizardCloseDelay
local FIntLuaAppPlayButtonWizardCloseDelayMs = require(SocialExperienceJoinParent.SharedFlags).FIntLuaAppPlayButtonWizardCloseDelayMs

local FStringLuaAppPlayButtonAgeCheckAmpFeatureName = require(SocialExperienceJoinParent.SharedFlags).FStringLuaAppPlayButtonAgeCheckAmpFeatureName

local FStringLuaAppPlayButtonAgeCheckAmpNameSpace = require(SocialExperienceJoinParent.SharedFlags).FStringLuaAppPlayButtonAgeCheckAmpNameSpace

local AmpUpsell = require(SocialExperienceJoinParent.AmpUpsell)
local OpenAmpWizardContainer = AmpUpsell.OpenAmpWizardContainer
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum

local delayedAmpWizardCompletionCallbackOverride = require(SocialExperienceJoinParent.GamePlayButton).delayedAmpWizardCompletionCallbackOverride

local tbl1 = {}

local function parseContentMaturityMapping(str1: string)
    local result = {}
    if str1 == "" then
        return result
    end
    for _, value in string.split(str1, ",") do
        local tbl2 = string.split(value, "=")
        if #tbl2 == 2 and tbl2[1] ~= "" and tbl2[2] ~= "" then
            result[tbl2[1]] = tbl2[2]
        end
    end
    return result
end

local tbl2 = parseContentMaturityMapping(
    (game:DefineFastString(
        "LuaAppUpsellMaturityRatingToSettingMapping",
        "mild=NinePlus,moderate=ThirteenPlus,restricted=SeventeenPlus,unrated=ThirteenPlus"
    ))
)

local function parentalControlsRequiresAgeCheck(arg1, str1: string?)
    if not (arg1 and str1) then
        return false
    end
    local contentAgeRestriction = arg1.contentAgeRestriction
    if not (contentAgeRestriction and contentAgeRestriction.options) then
        return false
    end
    local var1 = tbl2[str1]
    if not var1 then
        return false
    end
    for _, option in contentAgeRestriction.options do
        if option and option.option and option.option.optionValue == var1 then
            return option.requirement == "ContentAgeRestrictionVerification"
        end
    end
    return false
end

local function useAgeCheckUpsellState(str1: string, callback: ((...any) -> (...any))?)
    local var1 = useDispatch()
    local var2 = useRoactService(RoactNetworking)

    local playabilityChecked, var4 = React.useState(false)
    local var5, var6 = React.useState(false)

    local var7 = JoinCardCacheStore.get()
    local var8 = useSignalState(var7.getPlayabilityEntries)
    local var9 = useSignalState(var7.getUserSettings)
    local var10 = if str1 == "" then nil else var8[str1]
    local var11 = React.useRef(var10 ~= nil)

    local var12 = useSelector(function(arg1)
        local ageRecommendation = arg1.AgeRecommendations and arg1.AgeRecommendations[str1]

        if ageRecommendation and ageRecommendation.summary and ageRecommendation.summary.ageRecommendation then
            return ageRecommendation.summary.ageRecommendation.contentMaturity
        end

        return nil
    end)

    React.useEffect(function()
        if str1 == "" then
            var4(true)
            var6(false)
            return
        end

        if var7.getPlayabilityEntries(false)[str1] ~= nil then
            var4(true)
            var6(var7.getUserSettings(false) ~= nil)
            return
        end

        var6(false)
        var4(false)

        var1(NetworkingGames.GetExperiencesPlayabilityStatus.API({ str1 })):andThen(function(arg1)
            local var13 = arg1.responseBody and arg1.responseBody[1]
            if var13 then
                var7.setPlayabilityEntry(str1, var13)
            end
        end):catch(function() end):finally(function()
            var4(true)
        end)
    end, { var1, str1, var7 })

    React.useEffect(function()
        if str1 ~= ""
            and (var10 and var10.playabilityStatus) == PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls
        then
            var1(ApiFetchAgeRecommendations.Fetch(var2, str1)):catch(function() end):finally(function()
                var6(true)
            end)
        end
    end, {
        var1,
        var2,
        str1,
        var10
    })
    React.useEffect(function()
        if str1 == ""
            or (var10 and var10.playabilityStatus) ~= PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls
            or var7.getUserSettings(false) ~= nil
        then
            return
        end

        FetchUserSettingsAndOptions(var2):andThen(function(arg1)
            var7.setUserSettings(arg1)
        end):catch(function()
            var7.setUserSettings(tbl1)
        end)
    end, {
        var2,
        str1,
        var10,
        var7
    })

    local bool1 = not (var10 == nil or var10.playabilityStatus ~= PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls)
        and parentalControlsRequiresAgeCheck(var9, var12)
    local ageCheckRequired = not (var10 == nil)
        and (if var10.playabilityStatus == PlayabilityStatusEnum.ContextualPlayabilityUnverifiedSeventeenPlusUser
            or FFlagLuaAppPlayButtonAmpAgeCheckFlow
                and var10.playabilityStatus == PlayabilityStatusEnum.ContextualPlayabilityAgeCheckRequired then true else bool1)

    local refetchPlayability = React.useCallback(function()
        if str1 == "" then
            return
        end
        var1(NetworkingGames.GetExperiencesPlayabilityStatus.API({ str1 })):andThen(function(arg1)
            local var13 = arg1.responseBody and arg1.responseBody[1]
            if var13 then
                var7.setPlayabilityEntry(str1, var13)
            end
        end):catch(function()
            var7.clearPlayabilityEntry(str1)
        end)
        FetchUserSettingsAndOptions(var2):andThen(function(arg1)
            var7.setUserSettings(arg1)
        end):catch(function()
            var7.setUserSettings(tbl1)
        end)
    end, {
        var1,
        var2,
        str1,
        var7
    })
    local joinAgeCheckUpsellFlow = React.useCallback(function()
        local function onAmpWizardCompletion(str2: string?, _)
            local str3 = if str2 == AccessResponseEnum.Granted then "Success" elseif str2 == AccessResponseEnum.Error then "Error" else "Cancelled"

            if str3 == "Success" then
                refetchPlayability()
            end
            if callback then
                callback(str3)
            end
        end
        var1(
            OpenAmpWizardContainer(
                FStringLuaAppPlayButtonAgeCheckAmpFeatureName,
                onAmpWizardCompletion,
                nil,
                "joinCardAgeCheckRequired",
                nil,
                FStringLuaAppPlayButtonAgeCheckAmpNameSpace,
                nil,
                nil,
                if FFlagLuaAppPlayButtonWizardCloseDelay then delayedAmpWizardCompletionCallbackOverride(onAmpWizardCompletion, FIntLuaAppPlayButtonWizardCloseDelayMs) else nil
            )
        )
    end, { var1, refetchPlayability, callback })

    local pendingParentalControlsResolution = not (var10 == nil or var10.playabilityStatus ~= PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls)
        and (var9 == nil or var12 == nil and not var5)
    local playabilityStatus = if var10 then var10.playabilityStatus else nil

    return React.useMemo(function()
        return {
            cachedPlayabilityStatus = playabilityStatus,
            playabilityChecked = playabilityChecked,
            pendingParentalControlsResolution = pendingParentalControlsResolution,
            ageCheckRequired = ageCheckRequired,
            playabilityFromCache = var11.current,
            joinAgeCheckUpsellFlow = joinAgeCheckUpsellFlow,
            refetchPlayability = refetchPlayability
        }
    end, {
        playabilityStatus,
        playabilityChecked,
        pendingParentalControlsResolution,
        ageCheckRequired,
        joinAgeCheckUpsellFlow,
        refetchPlayability
    })
end

return useAgeCheckUpsellState
