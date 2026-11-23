-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Localization = require(BuildExperienceParent.Localization)
local useLocalization = Localization.Hooks.useLocalization

local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local useGetAdCampaigns = require(script.Parent.useGetAdCampaigns)
local useGetCampaignStats = require(script.Parent.useGetCampaignStats)
local useGetAdCampaignEligibility = require(script.Parent.useGetAdCampaignEligibility)
local useCreateAdCampaign = require(script.Parent.useCreateAdCampaign)
local adCampaignEligibilityUtils = require(script.Parent.adCampaignEligibilityUtils)
local adCampaignScheduleUtils = require(script.Parent.adCampaignScheduleUtils)
local getAdsManagerUrl = require(script.Parent.getAdsManagerUrl)
local useOpenWebViewWithResumeRefresh = require(BuildExperience.utils.useOpenWebViewWithResumeRefresh)
local CampaignStats = require(BuildExperienceParent.DataHydration.CampaignStats)
local _AdsStatsView = require(script.Parent.AdsStatsView)
local _PastCampaignRow = require(script.Parent.PastCampaignRow)
local _StatsCard = require(BuildExperience.Components.Analytics.StatsCard.StatsCard)
local AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)
local StatsCardValueFormat = require(BuildExperience.Components.Analytics.StatsCard.StatsCardValueFormat)
local Foundation = require(BuildExperienceParent.Foundation)
local _CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local FFlagEnablePaidAds = require(BuildExperience.Flags.FFlagEnablePaidAds)
local FFlagBuildAdsManagerUniverseUrl = require(BuildExperience.Flags.FFlagBuildAdsManagerUniverseUrl)

local IconName = Foundation.Enums.IconName
local IconPosition = Foundation.Enums.IconPosition

local MS_PER_DAY = adCampaignScheduleUtils.MS_PER_DAY
local toStartMs = adCampaignScheduleUtils.toStartMs
local campaignEndMs = adCampaignScheduleUtils.campaignEndMs
local campaignEndExclusiveMs = adCampaignScheduleUtils.campaignEndExclusiveMs

local WINDOW_DAYS = CampaignStats.WINDOW_DAYS
local tbl1 = { plays = 0, adClicks = 0, adViews = 0, playtimeSeconds = 0 }

local function toPlaytimeMinutes(playtimeSeconds: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return playtimeSeconds / 60
end

local function formatDateRange(dateRange: string, startMs: number?, endMs: number?)
    if startMs == nil or endMs == nil or startMs <= 0 then
        return nil
    end
    local tbl2 = {
        startDate = LocalizationStrings.formatCampaignDate(startMs),
        endDate = LocalizationStrings.formatCampaignDate(endMs)
    }
    return (string.gsub(dateRange, "{(%w+)}", function(str1: string)
        return tbl2[str1] or "{" .. str1 .. "}"
    end))
end

local function scalarCard(title: string, statValue: number, statIcon, hasData: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
    return {
        title = title,
        statValue = statValue,
        statUnit = AnalyticsUnit.Scalar,
        statValueFormat = StatsCardValueFormat.Regular,
        statIcon = statIcon,
        statIconPosition = IconPosition.Left,
        deltaValue = 0,
        deltaUnit = AnalyticsUnit.Percent,
        hasData = hasData
    }
end

local function useAdsStatsPageViewModel(num1: number?, arg1, arg2, num2: number?, arg3, arg4)
    local var1, var2 = useGetAdCampaigns(arg1)

    local bool1 = false
    if var1 ~= nil and num1 ~= nil then
        local str1 = tostring(num1)
        for _, value in var1 do
            if value.targetUniverseId == str1 then
                bool1 = true
                break
            end
        end
    end

    local var3, var4, var5 = useGetCampaignStats(if bool1 then num1 else nil, arg2)
    local current, var7 = useGetAdCampaignEligibility(num1, arg3)
    local var8 = useCreateAdCampaign(num1, nil, arg4)
    local isPromotionSheetOpen, var10 = React.useState(false)

    local adCampaignRunStartTimeMs, var12 = React.useState(nil)
    local var13 = nil
    local var14 = nil
    if FFlagEnablePaidAds then
        local var15
        var13, var15 = React.useState(nil)
        var14 = var15
    end
    local var15, var16 = React.useState(false)
    local var17 = React.useRef(nil)

    local onClosePromotionSheet = React.useCallback(function()
        var10(false)
        if FFlagEnablePaidAds then
            var8.clearCreateError()
        end
    end, { var8.clearCreateError })

    local var19, var20 = React.useState(false)
    local onDismissCreateSuccessToast = React.useCallback(function()
        var20(false)
    end, {})

    local var22 = React.useRef(false)
    React.useEffect(function()
        local current = var22.current
        var22.current = var8.isCreatePending
        if current and not (var8.isCreatePending or var8.hasCreateError) then
            var10(false)
            var20(true)
            var16(var17.current ~= nil)
        end
    end, { var8.isCreatePending, var8.hasCreateError })

    React.useEffect(function()
        local bool2 = var7 == "Ready" and current ~= nil and current ~= var17.current

        if var15 and (bool2 or var7 == "Failed") then
            var17.current = nil
            var16(false)
        end
    end, { var15, var7, current })

    React.useEffect(function()
        var17.current = nil
        var16(false)
        if FFlagEnablePaidAds then
            var14(nil)
        end
    end, { num1 })

    local var23 = React.useMemo(function(): number
        if num2 == nil then
            return DateTime.now().UnixTimestampMillis
        end

        return num2
    end, { num2 })

    local var24 = useLocalization({
        gamePlays = LocalizationStrings.ADS_STATS_GAME_PLAYS,
        adClicks = LocalizationStrings.ADS_STATS_AD_CLICKS,
        adViews = LocalizationStrings.ADS_STATS_AD_VIEWS,
        playTime = LocalizationStrings.ADS_STATS_PLAY_TIME,
        pastCampaigns = LocalizationStrings.ADS_STATS_PAST_CAMPAIGNS,
        error = LocalizationStrings.ADS_STATS_ERROR,
        dateRange = LocalizationStrings.ADS_STATS_DATE_RANGE,
        create = LocalizationStrings.PROMOTION_CREATE_BUTTON,
        emptyTitle = LocalizationStrings.ADS_STATS_EMPTY_TITLE,
        emptySubtitle = LocalizationStrings.ADS_STATS_EMPTY_SUBTITLE,
        emptyTitleFree = LocalizationStrings.ADS_STATS_EMPTY_TITLE_FREE,
        emptySubtitleFree = LocalizationStrings.ADS_STATS_EMPTY_SUBTITLE_FREE,
        adsManager = LocalizationStrings.ADS_STATS_ADS_MANAGER,
        createSuccess = LocalizationStrings.ADS_STATS_CREATE_SUCCESS
    })
    local gamePlays = var24.gamePlays
    local adClicks = var24.adClicks
    local adViews = var24.adViews
    local playTime = var24.playTime
    local pastCampaigns = var24.pastCampaigns
    local error = var24.error

    local dateRange = var24.dateRange

    local var25 = var24[Localization.RobloxLocaleIdKey]

    local var26 = React.useMemo(function()
        local var26 = var1 or {}
        local var27 = var3 or {}
        local var28 = var23 - WINDOW_DAYS * MS_PER_DAY
        local var29 = if num1 == nil then nil else tostring(num1)
        local tbl2 = {}
        local tbl3 = {}

        for _, value in var26 do
            if var29 == nil or value.targetUniverseId ~= var29 then
                continue
            end

            local stats = var27[value.id] or tbl1
            local startMs = toStartMs(value.schedule.startTime)
            local endMs = campaignEndMs(startMs, value.schedule.durationInDays)

            local bool2 = value.status == "CANCELLED"
            local var33 = campaignEndExclusiveMs(startMs, value.schedule.durationInDays)
            if not bool2 and var23 < var33 then
                table.insert(tbl2, { id = value.id, stats = stats, startMs = startMs, endMs = endMs })
            elseif var28 <= startMs then
                table.insert(tbl3, { stats = stats, startMs = startMs, endMs = endMs })
            end
        end

        table.sort(tbl2, function(arg5, arg6): boolean
            if arg5.startMs == arg6.startMs then
                return arg5.id < arg6.id
            end

            return arg5.startMs > arg6.startMs
        end)

        table.sort(tbl3, function(arg5, arg6): boolean
            return arg5.endMs > arg6.endMs
        end)

        local function buildSummaryCards(stats)
            return {
                scalarCard(gamePlays, stats.plays, IconName.CirclePlay, not var5.plays),
                scalarCard(adClicks, stats.adClicks, IconName.Crosshairs, not var5.adClicks),
                scalarCard(adViews, stats.adViews, IconName.Eye, not var5.adViews),
                {
                    title = playTime,
                    statValue = toPlaytimeMinutes(stats.playtimeSeconds),
                    statUnit = AnalyticsUnit.Temporal,
                    statIcon = IconName.Clock,
                    statIconPosition = IconPosition.Left,
                    deltaValue = 0,
                    deltaUnit = AnalyticsUnit.Percent,
                    hasData = not var5.playtimeSeconds
                }
            }
        end

        local activeCampaigns = {}
        for _, value in tbl2 do
            table.insert(activeCampaigns, {
                id = value.id,
                dateText = formatDateRange(dateRange, value.startMs, value.endMs) or "",
                summaryCards = buildSummaryCards(value.stats)
            })
        end

        local tbl4 = {}
        for _, value in tbl3 do
            table.insert(tbl4, {
                dateText = formatDateRange(dateRange, value.startMs, value.endMs) or "",
                adViews = if var5.adViews then nil else value.stats.adViews,
                adClicks = if var5.adClicks then nil else value.stats.adClicks,
                gamePlays = if var5.plays then nil else value.stats.plays,
                labels = { adViews = adViews, adClicks = adClicks, gamePlays = gamePlays }
            })
        end

        return { activeCampaigns = activeCampaigns, pastCampaigns = tbl4 }
    end, {
        num1,
        var1,
        var3,
        var5,
        var23,
        gamePlays,
        adClicks,
        adViews,
        playTime,
        dateRange,
        var25
    })

    local hasCampaigns = #var26.activeCampaigns > 0 or #var26.pastCampaigns > 0

    local isFailed = var2 == "Failed" or bool1 and var4 == "Failed"
    local bool4 = not hasCampaigns

    if bool4 then
        if num1 == nil then
            bool4 = false
        else
            bool4 = var7 == "NotReady"
        end
    end
    local bool5 = not isFailed

    if bool5 then
        if var2 == "NotReady" then
            bool4 = true
        elseif bool1 then
            bool4 = var4 == "NotReady" or bool4
        end
    else
        bool4 = bool5
    end

    local showCreateSuccessToast = var19 and not (bool4 or isFailed)
    local offer = if current == nil then nil else current.offer
    local selectableOffers = if FFlagEnablePaidAds then adCampaignEligibilityUtils.getSelectableOffers(current) else nil
    local durationDays = if offer == nil then nil else offer.durationDays
    local var28 = if adCampaignRunStartTimeMs == nil or durationDays == nil then nil else adCampaignRunStartTimeMs + math.max(0, durationDays - 1) * MS_PER_DAY
    local var29 = adCampaignEligibilityUtils.hasFreeCredit(current)

    local var30 = adCampaignEligibilityUtils.isEligibleForFreePromotion(current) and var29

    local var31 = adCampaignEligibilityUtils.canCreateCampaign(current)
    local emptyTitle = if var30 then var24.emptyTitleFree else var24.emptyTitle
    local emptySubtitle = if var30 then var24.emptySubtitleFree else var24.emptySubtitle
    local adsManager = var24.adsManager
    local var34

    if FFlagBuildAdsManagerUniverseUrl then
        local adsManagerUrl = getAdsManagerUrl.getAdsManagerUrl(num1)
        var34 = useOpenWebViewWithResumeRefresh(adsManagerUrl, adsManager, var8.refresh)
    else
        var34 = useOpenWebViewWithResumeRefresh(getAdsManagerUrl.getDefaultAdsManagerUrl(), adsManager, var8.refresh)
    end

    local onCreatePrimary = React.useCallback(function()
        if var15 then
            return
        end

        if not var31 then
            var34()
            return
        end

        var20(false)
        if not FFlagEnablePaidAds then
            var8.clearCreateError()
        end
        var12(DateTime.now().UnixTimestampMillis)
        if FFlagEnablePaidAds then
            var14(function(arg5)
                return if var8.hasCreateError and arg5 ~= nil then arg5 else selectableOffers
            end)
        end
        var10(true)
    end, {
        var15,
        var31,
        var34,
        var8.clearCreateError,
        var8.hasCreateError,
        selectableOffers
    })

    local onCreateCampaign = React.useCallback(function(arg5)
        var17.current = current
        local createCampaign = var8.createCampaign

        if not FFlagEnablePaidAds then
            arg5 = nil
        end

        createCampaign(arg5)
    end, { current, var8.createCampaign })

    return {
        activeCampaigns = var26.activeCampaigns,
        universeId = if FFlagBuildAdsManagerUniverseUrl then num1 else nil,
        pastCampaignsTitle = pastCampaigns,
        pastCampaigns = var26.pastCampaigns,
        errorText = error,
        isLoading = bool4,
        isFailed = isFailed,
        hasCampaigns = hasCampaigns,
        emptyTitle = emptyTitle,
        emptySubtitle = emptySubtitle,
        createButtonText = var24.create,
        createButtonIsExternal = not var31,
        isPromotionCreatePending = var8.isCreatePending or var15,
        hasPromotionCreateError = var8.hasCreateError,
        promotionCreateErrorKind = var8.createErrorKind,
        showCreateSuccessToast = showCreateSuccessToast,
        createSuccessToastText = var24.createSuccess,
        onDismissCreateSuccessToast = onDismissCreateSuccessToast,
        isPromotionSheetOpen = isPromotionSheetOpen,
        adCampaignDurationDays = durationDays,
        adCampaignEstimatedPriceRobux = if offer == nil then nil else offer.displayAmountRobux,
        adCampaignOffers = var13,
        adCampaignRunStartTimeMs = adCampaignRunStartTimeMs,
        adCampaignRunEndTimeMs = var28,
        onCreatePrimary = onCreatePrimary,
        onClosePromotionSheet = onClosePromotionSheet,
        onCreateCampaign = onCreateCampaign
    }
end

return useAdsStatsPageViewModel
