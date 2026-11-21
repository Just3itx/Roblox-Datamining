-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local PromiseUtilities = require(GamePlayButtonParent.AppCommonLib).Utils.PromiseUtilities
local RetrievalStatus = require(GamePlayButtonParent.Http).Enum.RetrievalStatus
local GameDetailRodux = require(GamePlayButtonParent.GameDetailRodux)
local ApiFetchGameDetails = GameDetailRodux.GameDetails.ApiFetchGameDetails
local FetchGamePlayabilityAndProductInfo = GameDetailRodux.FetchGamePlayabilityAndProductInfo
local ApiFetchAgeRecommendations = GameDetailRodux.AgeRecommendations.ApiFetchAgeRecommendations
local FetchUserGameVotes = require(GamePlayButtonParent.GameVotesRodux).UserGameVotes.FetchUserGameVotes
local DataHydration = require(GamePlayButtonParent.DataHydration)
local NextDataExpirationTimeRodux = require(GamePlayButtonParent.NextDataExpirationTimeRodux)
local SetNextDataExpirationTime = NextDataExpirationTimeRodux.SetNextDataExpirationTime
local NextDataExpirationTimeReducer = NextDataExpirationTimeRodux.NextDataExpirationTimeReducer
local ExpirationTimeNamespace = NextDataExpirationTimeRodux.ExpirationTimeNamespace
local PlayabilityStatusEnum = require(GamePlayButtonParent.DiscoveryTypes).PlayabilityStatusEnum

local ApiFetchShowAgeVerificationOverlay = require(GamePlayButtonParent.VoiceChat).AgeVerificationOverlay.ApiFetchShowAgeVerificationOverlay
local Promise = require(GamePlayButtonParent.Promise)

local FFlagLuaAppPlayButtonCoalescePlayabilityFetch = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonCoalescePlayabilityFetch

local GetFIntLuaAppThrottleRefreshPlayabilityIntervalSeconds = require(GamePlayButtonParent.SharedFlags).GetFIntLuaAppThrottleRefreshPlayabilityIntervalSeconds

local RunService = game:GetService("RunService")

local module = {}

local var1 = (setmetatable({}, { __mode = "k" }))

local function hasInFlightBatch(arg1, str1: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = var1[arg1]
    return not (var2 == nil) and var2[str1] ~= nil
end

local function startInFlightBatch(arg1, str1: string)
    local tbl1 = var1[arg1]
    if tbl1 == nil then
        tbl1 = {}
        var1[arg1] = tbl1
    end
    local tbl2 = tbl1[str1]
    if tbl2 == nil then
        tbl2 = { count = 0, hadFailure = false }
        tbl1[str1] = tbl2
    end
    tbl2.count += 1
end

local function finishInFlightBatch(arg1, str1: string, bool1: boolean): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = var1[arg1]
    local var3 = if var2 then var2[str1] else nil

    if var2 == nil or var3 == nil then
        return bool1
    end
    var3.count -= 1
    if not bool1 then
        var3.hadFailure = true
    end
    if var3.count > 0 then
        return false
    end
    var2[str1] = nil
    return not var3.hadFailure
end

local function hasContentMaturity(arg1, arg2): boolean
    local ageRecommendation = arg1.AgeRecommendations and arg1.AgeRecommendations[arg2]
    if ageRecommendation
        and ageRecommendation.summary
        and ageRecommendation.summary.ageRecommendation
        and ageRecommendation.summary.ageRecommendation.contentMaturity
    then
        return true
    end
    local var2 = DataHydration.Game.getGameInfoStore(false).getGameInfo(arg2).data(false)
    return not (var2 == nil) and var2.contentMaturity ~= nil
end

local function shouldFetchAgeRecommendations(arg1, arg2, contextualPlayabilityAgeRecommendationParentalControls): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return contextualPlayabilityAgeRecommendationParentalControls == PlayabilityStatusEnum.ContextualPlayabilityAgeRecommendationParentalControls
        and not hasContentMaturity(arg1, arg2)
end

local function playButtonDataFetchPromises(arg1, arg2, str1: string, bool1: boolean, bool2: boolean?)
    local result = {}

    if ApiFetchGameDetails.GetFetchingStatus(arg2:getState(), str1) ~= RetrievalStatus.Fetching
        and (bool1 or arg2:getState().GameDetails[str1] == nil)
    then
        local fetch = ApiFetchGameDetails.Fetch
        table.insert(result, arg2:dispatch(fetch(arg1, { str1 })))
    end

    local fetchingStatus = FetchGamePlayabilityAndProductInfo.GetFetchingStatus(arg2:getState(), str1)

    if bool1 or bool2 or fetchingStatus == RetrievalStatus.NotStarted or fetchingStatus == RetrievalStatus.Failed then
        table.insert(result, (arg2:dispatch(FetchGamePlayabilityAndProductInfo.Fetch(arg1, str1)):andThen(function(contextualPlayabilityAgeRecommendationParentalControls)
            if shouldFetchAgeRecommendations(arg2:getState(), str1, contextualPlayabilityAgeRecommendationParentalControls) then
                return arg2:dispatch(ApiFetchAgeRecommendations.Fetch(arg1, str1))
            end
            return Promise.resolve(contextualPlayabilityAgeRecommendationParentalControls)
        end)))
    end
    if game:GetEngineFeature("VoiceChatSupported")
        and ApiFetchShowAgeVerificationOverlay.GetFetchingStatus(arg2:getState(), str1) ~= RetrievalStatus.Fetching
        and (bool1 or arg2:getState().ShowAgeVerificationOverlay[str1] == nil)
    then
        local fetch = ApiFetchShowAgeVerificationOverlay.Fetch
        table.insert(result, arg2:dispatch(fetch(arg1, str1)))
    end

    if FetchUserGameVotes.GetFetchingStatus(arg2:getState(), str1) ~= RetrievalStatus.Fetching
        and (bool1 or arg2:getState().UserGameVotes[str1] == nil)
    then
        arg2:dispatch(FetchUserGameVotes.Fetch(arg1, str1))
    end

    return result
end

function module.IsLoading(arg1, arg2)
    local fetchingStatus = ApiFetchGameDetails.GetFetchingStatus(arg1, arg2)

    if fetchingStatus == RetrievalStatus.NotStarted or fetchingStatus == RetrievalStatus.Fetching then
        return true
    end

    local fetchingStatus2 = FetchGamePlayabilityAndProductInfo.GetFetchingStatus(arg1, arg2)

    if fetchingStatus2 == RetrievalStatus.NotStarted or fetchingStatus2 == RetrievalStatus.Fetching then
        return true
    end
    local var2 = arg1.PlayabilityStatus and arg1.PlayabilityStatus[arg2]

    if var2 and shouldFetchAgeRecommendations(arg1, arg2, var2.playabilityStatus) then
        local fetchingStatus3 = ApiFetchAgeRecommendations.GetFetchingStatus(arg1, arg2)

        if fetchingStatus3 == RetrievalStatus.NotStarted or fetchingStatus3 == RetrievalStatus.Fetching then
            return true
        end
    end

    if game:GetEngineFeature("VoiceChatSupported") then
        local fetchingStatus3 = ApiFetchShowAgeVerificationOverlay.GetFetchingStatus(arg1, arg2)

        if fetchingStatus3 == RetrievalStatus.NotStarted or fetchingStatus3 == RetrievalStatus.Fetching then
            return true
        end
    end

    return false
end

function module.Fetch(arg1, str1: string, bool1: boolean?)
    return function(arg2)
        local var2 = tick()
        local var3 = nil

        local var4 = arg2:getState().Personalization[NextDataExpirationTimeReducer.key][ExpirationTimeNamespace.GameDetailPlayability]
        if var4 then
            var3 = var4[str1]
        end

        local bool2 = false
        if var3 == nil or var3 < var2 then
            bool2 = true
        end

        if FFlagLuaAppPlayButtonCoalescePlayabilityFetch and hasInFlightBatch(arg2, str1) and not bool1 then
            bool2 = false
        end

        local tbl1 = playButtonDataFetchPromises(arg1, arg2, str1, bool2, bool1)

        if not (#tbl1 > 0) then
            return nil
        end

        local warn = if _G.__TESTEZ_RUNNING_TEST__ or RunService:IsStudio() then warn else nil

        if FFlagLuaAppPlayButtonCoalescePlayabilityFetch then
            startInFlightBatch(arg2, str1)
        end

        return (PromiseUtilities.Batch(tbl1, warn):andThen(function(arg3)
            local failureCount = PromiseUtilities.CountResults(arg3).failureCount

            if if FFlagLuaAppPlayButtonCoalescePlayabilityFetch then finishInFlightBatch(arg2, str1, failureCount == 0) else failureCount == 0 then
                var2 = tick()
                var3 = math.floor(var2 + GetFIntLuaAppThrottleRefreshPlayabilityIntervalSeconds())
                arg2:dispatch(SetNextDataExpirationTime(str1, var3, ExpirationTimeNamespace.GameDetailPlayability))
            end
        end))
    end
end

return module
