-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent
local Cryo = require(SduiSharedContentParent.Cryo)
local React = require(SduiSharedContentParent.React)
local PlayButton = require(SduiSharedContentParent.GamePlayButton).PlayButton

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local executeAction = SduiCoreSystem.executeAction
local findAnalyticsField = SduiCoreSystem.findAnalyticsField
local SduiActionType = SduiCoreSystem.SduiActionType
local getSduiActionHandlerRegistry = SduiCoreSystem.getSduiActionHandlerRegistry

local useSduiReportExperienceLaunched = require(SduiSharedContent.Components.useSduiReportExperienceLaunched)
local getSduiFocusActivationStore = require(SduiSharedContentParent.SduiSharedUtilities).getSduiFocusActivationStore
local AppPage = require(SduiSharedContentParent.RobloxAppEnums).AppPage
local FFlagLuaAppLaunchWhenLoadingEdp = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppLaunchWhenLoadingEdp
local FFlagEnableGameJoinEarlyAccess = require(SduiSharedContentParent.SharedFlags).FFlagEnableGameJoinEarlyAccess

return React.memo(function(tbl1) -- name: SduiPlayButton
    local analyticsContext = tbl1.analyticsContext

    local var1 = React.useCallback(function()
        local var1 = getSduiActionHandlerRegistry().getActionHandlerConfig(SduiActionType.OpenGameDetails)
        if var1 and var1.handler then
            var1.handler(nil, tbl1.analyticsContext, tbl1.sduiContext)
        end
    end, { tbl1.sduiContext, tbl1.analyticsContext })

    local var2 = tbl1.placeId or tbl1.rootPlaceId
    local var3 = tbl1.rootPlaceId or var2
    local universeId = tbl1.universeId
    local eventContext = findAnalyticsField("eventContext", analyticsContext.analyticsData, "ExperienceTile")
    local referralSource = findAnalyticsField("referralSource", analyticsContext.analyticsData)
    local launchData = if tbl1.experienceJoinData then tbl1.experienceJoinData.launchData else nil
    local reportExperienceLaunched = useSduiReportExperienceLaunched(
        tbl1.sduiContext,
        tbl1.analyticsContext,
        universeId,
        var2,
        var3,
        tbl1.appliedFilters,
        launchData
    )

    local onActivated = React.useCallback(function()
        if tbl1.onActivatedEffect then
            tbl1.onActivatedEffect()
        end

        local tbl2 = {
            actionType = SduiActionType.PlayButtonClick
        }

        executeAction(tbl2, analyticsContext, tbl1.sduiContext)
    end, { analyticsContext, tbl1.sduiContext, tbl1.onActivatedEffect })

    local onRegisterActivation = React.useCallback(function(func1: (...any) -> (...any))
        local tag = tbl1.tag
        if tag == nil then
            return function() end
        end
        return getSduiFocusActivationStore().register(tag, func1)
    end, { tbl1.tag })

    local anchorPoint = tbl1.anchorPoint
    local layoutOrder = tbl1.layoutOrder
    local position = tbl1.position

    local launchSource = findAnalyticsField("launchSource", analyticsContext.analyticsData)

    local fetchDelayInSeconds = tbl1.fetchDelayInSeconds or 0.1

    local var7 = FFlagEnableGameJoinEarlyAccess
        and (tbl1.sduiContext.appPage == AppPage.ExperienceDetail or tbl1.sduiContext.appPage == AppPage.GameDetail)

    local createElement = React.createElement
    local var8 = PlayButton
    local join = Cryo.Dictionary.join
    local tbl2 = {
        AnchorPoint = anchorPoint,
        LayoutOrder = layoutOrder,
        Position = position,
        tag = tbl1.tag,
        expandWidthForSecondaryPlayButton = tbl1.expandWidthForSecondaryPlayButton,
        preferSecondaryPlayButton = tbl1.preferSecondaryPlayButton,
        onRegisterActivation = onRegisterActivation,
        fetchDelayInSeconds = fetchDelayInSeconds,
        universeId = tbl1.universeId,
        placeId = tbl1.placeId,
        useUIBloxButton = tbl1.enableUiBloxButton,
        reportExperienceLaunched = reportExperienceLaunched,
        onPurchaseRequiredCallback = 0,
        onActivated = 0,
        referralSource = 0,
        eventContext = 0,
        launchSource = 0,
        launchWhenLoading = 0,
        launchOnReleaseAfterUnmount = 0,
        enableEarlyAccessPlusTooltip = 0,
        enableEarlyAccessState = 0
    }

    if not tbl1.openGameDetailsOnPurchaseRequired then
        var1 = nil
    end

    tbl2.onPurchaseRequiredCallback = var1
    tbl2.onActivated = onActivated
    tbl2.referralSource = referralSource
    tbl2.eventContext = eventContext
    tbl2.launchSource = launchSource
    tbl2.launchWhenLoading = if FFlagLuaAppLaunchWhenLoadingEdp then tbl1.launchWhenLoading else nil
    tbl2.launchOnReleaseAfterUnmount = tbl1.launchOnReleaseAfterUnmount
    tbl2.enableEarlyAccessPlusTooltip = if FFlagEnableGameJoinEarlyAccess and var7 then true else nil

    tbl2.enableEarlyAccessState = if FFlagEnableGameJoinEarlyAccess and tbl1.enableEarlyAccessState ~= nil then tbl1.enableEarlyAccessState elseif FFlagEnableGameJoinEarlyAccess and var7 then true else nil
    return createElement(var8, join(tbl1, tbl2))
end)
