-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Signals = require(MomentsCommonParent.Signals)

local SharedFlags = require(MomentsCommonParent.SharedFlags)
local FFlagMomentsAutoplayAmpPolicy = SharedFlags.FFlagMomentsAutoplayAmpPolicy
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsCommentsIxpEnabled = SharedFlags.FFlagMomentsCommentsIxpEnabled
local FFlagMomentsReactFeatureGate = SharedFlags.FFlagMomentsReactFeatureGate
local FFlagMomentsCreationFeatureGate = SharedFlags.FFlagMomentsCreationFeatureGate
local FFlagAXAvatarMomentsCreation = SharedFlags.FFlagAXAvatarMomentsCreation
local FFlagMomentsEngagementMetricsFeature = require(MomentsCommon.Flags.FFlagMomentsEngagementMetricsFeature)
local FFlagDebugForceEnableMoments = require(MomentsCommon.Flags.FFlagDebugForceEnableMoments)
local FFlagMomentsParentTimeLimit = require(MomentsCommon.Flags.FFlagMomentsParentTimeLimit)
local GetFFlagMomentsNonInfiniteScroll = require(MomentsCommon.Flags.GetFFlagMomentsNonInfiniteScroll)
local GetFIntMomentsNonInfiniteScrollLimit = require(MomentsCommon.Flags.GetFIntMomentsNonInfiniteScrollLimit)

local createComputed = Signals.createComputed

local GetAppPolicyStore = require(MomentsCommonParent.UniversalAppPolicy).GetAppPolicyStore

local function createMomentsCapabilities()
    local fFlagMomentsNonInfiniteScroll = GetFFlagMomentsNonInfiniteScroll()

    local num1 = math.max(1, GetFIntMomentsNonInfiniteScrollLimit())

    local function policyCapability(str1: string) -- Luacid: Inlined by compiler; 10 call sites recovered
        return createComputed(function(arg1): boolean
            if FFlagDebugForceEnableMoments then
                return true
            end
            local var1 = GetAppPolicyStore(false).getAppPolicy(arg1)
            return table.find(var1.getMomentsFeatureList(), str1) ~= nil
        end)
    end

    local getHasMomentsAccess = policyCapability("moments_access")
    local getIsInfluencerContentEnabled = policyCapability("influencer_content")
    local getCanCreateMoments = if FFlagMomentsCreationFeatureGate then policyCapability("moments_creation") else nil
    local getCanCreateAvatarMoments = if FFlagAXAvatarMomentsCreation then policyCapability("avatar_creation") else nil
    local getIsAutoPlayEnabled = if FFlagMomentsAutoplayAmpPolicy then policyCapability("auto_play") else nil
    local getIsEngagementMetricsEnabled = if FFlagMomentsEngagementMetricsFeature then policyCapability("engagement_metrics") else nil
    local getCanReactToMoments = if FFlagMomentsReactFeatureGate then policyCapability("moments_react") else nil
    local var8 = FFlagMomentsComments or FFlagMomentsCommentsIxpEnabled
    local getCanReadComments = if var8 then policyCapability("comments_read") else nil
    local getCanWriteComments = if var8 then policyCapability("comments_write") else nil
    local getCanReactToComments = if var8 then policyCapability("comments_react") else nil

    local getCanShowPersonalizedRecommendationsEntryPoint = createComputed(function(arg1)
        return GetAppPolicyStore(false).getAppPolicy(arg1).getShowInContextPersonalizedRecommendationsMomentsFeed()
    end)

    local getIsInfiniteScrollEnabled = createComputed(function(arg1): boolean
        if not fFlagMomentsNonInfiniteScroll then
            return true
        end
        if FFlagDebugForceEnableMoments then
            return true
        end
        local var12 = GetAppPolicyStore(false).getAppPolicy(arg1).getMomentsFeatureList()

        return next(var12) == nil or table.find(var12, "infinite_scroll") ~= nil
    end)

    local getMaxMomentsBeforeEndState = createComputed(function(_)
        return num1
    end)

    local getHasDailyLimit = if FFlagMomentsParentTimeLimit then createComputed(function(arg1): boolean
        if require(MomentsCommon.Flags.FFlagDebugForceMomentsDailyLimit) then
            return true
        end
        local var12 = GetAppPolicyStore(false).getAppPolicy(arg1)
        return table.find(var12.getMomentsFeatureList(), "moments_daily_limit") ~= nil
    end) else nil

    return {
        getHasMomentsAccess = getHasMomentsAccess,
        getIsInfluencerContentEnabled = getIsInfluencerContentEnabled,
        getCanCreateMoments = getCanCreateMoments,
        getCanCreateAvatarMoments = getCanCreateAvatarMoments,
        getIsAutoPlayEnabled = getIsAutoPlayEnabled,
        getIsEngagementMetricsEnabled = getIsEngagementMetricsEnabled,
        getCanReactToMoments = getCanReactToMoments,
        getCanReadComments = getCanReadComments,
        getCanWriteComments = getCanWriteComments,
        getCanReactToComments = getCanReactToComments,
        getCanShowPersonalizedRecommendationsEntryPoint = getCanShowPersonalizedRecommendationsEntryPoint,
        getIsInfiniteScrollEnabled = getIsInfiniteScrollEnabled,
        getMaxMomentsBeforeEndState = getMaxMomentsBeforeEndState,
        getHasDailyLimit = getHasDailyLimit
    }
end

return createMomentsCapabilities
