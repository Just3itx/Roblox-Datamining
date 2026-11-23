-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Navigation = require(BuildExperienceParent.Navigation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local UrlBuilder = require(BuildExperienceParent.UrlBuilder).UrlBuilder
local useOpenWebView = require(BuildExperienceParent.WebViewUtils).useOpenWebView
local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local GoalLockedActionId = require(BuildExperience.Analytics.Goals.GoalLockedActionId)
local _GoalTypes = require(BuildExperience.Analytics.Goals.GoalTypes)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local FFlagBuildAdsManagerUniverseUrl = require(BuildExperience.Flags.FFlagBuildAdsManagerUniverseUrl)
local FFlagBuildExperienceMonetizationNativeUI = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationNativeUI)
local FFlagEnablePaidAds = require(BuildExperience.Flags.FFlagEnablePaidAds)
local adCampaignEligibilityUtils = require(BuildExperience.Components.Ads.adCampaignEligibilityUtils)
local adCampaignScheduleUtils = require(BuildExperience.Components.Ads.adCampaignScheduleUtils)
local AdCampaignCreatedToast = require(BuildExperience.Components.Ads.AdCampaignCreatedToast)
local CreateAdCampaignSheetContainer = require(BuildExperience.Components.Ads.CreateAdCampaignSheet.CreateAdCampaignSheetContainer)
local getAdsManagerUrl = require(BuildExperience.Components.Ads.getAdsManagerUrl).getAdsManagerUrl
local useCreateAdCampaign = require(BuildExperience.Components.Ads.useCreateAdCampaign)
local useGetAdCampaignEligibility = require(BuildExperience.Components.Ads.useGetAdCampaignEligibility)
local useGetAdCampaigns = require(BuildExperience.Components.Ads.useGetAdCampaigns)
local ExperienceShareOverlays = require(BuildExperience.Components.ShareAudience.ExperienceShareOverlays)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local BuildNavigationParams = require(BuildExperience.utils.BuildNavigationParams)
local useExperienceShareFlow = require(BuildExperience.utils.useExperienceShareFlow)

local string2 = UrlBuilder.fromString("create:dashboard/creations/experiences/{universeId}/monetization/developer-products")

local function useCreateAdAction(num1: number)
    local var1 = useLocalization(
        {
            adsManager = LocalizationStrings.ADS_STATS_ADS_MANAGER,
            createSuccess = LocalizationStrings.ADS_STATS_CREATE_SUCCESS
        }
    )
    local var2 = useOpenWebView()
    local adsManager = var1.adsManager

    local current, var4 = useGetAdCampaignEligibility(if FFlagEnablePaidAds then num1 else nil)
    local var5 = useCreateAdCampaign(num1)
    local clearCreateError = var5.clearCreateError
    local createCampaign = var5.createCampaign
    local isCreatePending = var5.isCreatePending
    local hasCreateError = var5.hasCreateError

    local isOpen, var7 = React.useState(false)
    local var8, var9 = React.useState(false)
    local var10, var11 = React.useState(nil)
    local var12, var13 = React.useState(false)
    local var14 = React.useRef(nil)

    local var15 = adCampaignEligibilityUtils.canCreateCampaign(current)

    local var16, var17 = useGetAdCampaigns()

    local isEligible = not (var17 == "Ready" and adCampaignScheduleUtils.hasActiveCampaign(var16, num1, DateTime.now().UnixTimestampMillis))

    local onActivate = React.useCallback(function()
        if var12 then
            return
        end

        if not (FFlagEnablePaidAds and var15) then
            var2(getAdsManagerUrl(num1), adsManager)
            return
        end

        var9(false)

        var11(function(arg1)
            if hasCreateError and arg1 ~= nil then
                return arg1
            end
            return adCampaignEligibilityUtils.campaignSheetTerms(current, DateTime.now().UnixTimestampMillis)
        end)
        var7(true)
    end, {
        var12,
        var15,
        var2,
        num1,
        adsManager,
        clearCreateError,
        hasCreateError,
        current
    })

    local onClose = React.useCallback(function()
        var7(false)
        clearCreateError()
    end, { clearCreateError })

    local onCreate = React.useCallback(function(arg1)
        var14.current = current
        createCampaign(arg1)
    end, { current, createCampaign })

    local var21 = React.useRef(false)
    React.useEffect(function()
        local current = var21.current
        var21.current = isCreatePending
        if current and not (isCreatePending or hasCreateError) then
            var7(false)
            var9(true)
            var13(var14.current ~= nil)
        end
    end, { isCreatePending, hasCreateError })

    React.useEffect(function()
        local bool2 = var4 == "Ready" and current ~= nil and current ~= var14.current

        if var12 and (bool2 or var4 == "Failed") then
            var14.current = nil
            var13(false)
        end
    end, { var12, var4, current })

    React.useEffect(function()
        var14.current = nil
        var13(false)
        var11(nil)
    end, { num1 })

    local var3 = React.useCallback(function()
        var9(false)
    end, {})

    local runStartMs = if var10 == nil then nil else var10.runStartMs
    local durationDays = if var10 == nil then nil else var10.durationDays
    local var23

    if FFlagEnablePaidAds then
        local createElement = React.createElement
        local fragment = React.Fragment
        local var24 = nil
        local tbl1 = {
            Sheet = React.createElement(CreateAdCampaignSheetContainer, {
                universeId = if FFlagBuildAdsManagerUniverseUrl then num1 else nil,
                isOpen = isOpen,
                onClose = onClose,
                onCreate = onCreate,
                waitForCreateResult = true,
                isCreatePending = isCreatePending or var12,
                hasCreateError = hasCreateError,
                createErrorKind = var5.createErrorKind,
                useLocalRunDates = true,
                campaignDurationDays = durationDays,
                estimatedPriceRobux = if var10 == nil then nil else var10.estimatedPriceRobux,
                campaignOffers = if var10 == nil then nil else var10.campaignOffers,
                runStartTimeMs = runStartMs,
                runEndTimeMs = if runStartMs == nil or durationDays == nil then nil else adCampaignScheduleUtils.campaignEndMs(runStartMs, durationDays)
            }),
            Toast = if var8 then React.createElement(
                AdCampaignCreatedToast,
                {
                    onClose = var3,
                    testId = "GoalAdCampaignCreatedToast",
                    title = var1.createSuccess
                }
            ) else nil
        }
        var23 = createElement(fragment, var24, tbl1)
    else
        var23 = nil
    end

    local isLoading = var17 == "NotReady"

    return React.useMemo(function()
        return {
            onActivate = onActivate,
            isEligible = isEligible,
            isLoading = isLoading,
            overlay = var23
        }
    end, {
        onActivate,
        var23,
        isEligible,
        isLoading
    })
end

local function useSellItemsAction(universeId: number, num2: number, target: number)
    local var1 = useLocalization({ creatorHub = LocalizationStrings.GAME_CONFIGURATION_CREATOR_HUB })
    local var2 = useOpenWebView()
    local creatorHub = var1.creatorHub

    local onActivate = React.useCallback(function()
        if FFlagBuildExperienceMonetizationNativeUI and num2 ~= nil and target ~= nil then
            num2.navigate("BuildMonetization", { target = target })
            return
        end
        var2(string2({ universeId = universeId }), creatorHub)
    end, {
        universeId,
        num2,
        target,
        var2,
        creatorHub
    })
    return React.useMemo(function()
        return { onActivate = onActivate, isEligible = true }
    end, { onActivate })
end

local function useShareWithFriendsAction(num1: number, num2: number?)
    local var1 = useExperienceShareFlow(num1, num2)
    local onShare = var1.onShare

    local overlay = React.createElement(ExperienceShareOverlays, {
        activeDialog = var1.activeDialog,
        hasShareError = var1.hasShareError,
        onCancel = var1.onCancelDialog,
        onConfirmFriends = var1.onConfirmFriends,
        onConfirmPlaytesters = var1.onConfirmPlaytesters
    })

    return React.useMemo(function()
        return { onActivate = onShare, isEligible = true, overlay = overlay }
    end, { onShare, overlay })
end

local function useGoalLockedActions(num1: number)
    local var1 = Navigation.useNavigation()
    local target = if var1 == nil then nil else BuildNavigationParams.getTarget(var1)
    local var2 = useCreateAdAction(num1)
    local var3 = useSellItemsAction(num1, var1, target)
    local var4 = useShareWithFriendsAction(num1, if target == nil then nil else target.placeId)

    return {
        actions = React.useMemo(function()
            return {
                [GoalLockedActionId.CreateAd] = var2,
                [GoalLockedActionId.SellItems] = var3,
                [GoalLockedActionId.ShareWithFriends] = var4
            }
        end, { var2, var3, var4 })
    }
end
return useGoalLockedActions
