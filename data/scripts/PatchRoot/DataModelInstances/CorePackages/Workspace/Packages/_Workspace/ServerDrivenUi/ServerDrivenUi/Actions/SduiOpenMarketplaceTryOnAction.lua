-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local UnifiedEventLogConstants = require(ServerDrivenUiParent.AvatarExperienceAnalytics).UnifiedEventLogConstants
local UnifiedEventLogEnums = require(ServerDrivenUiParent.AvatarExperienceAnalytics).UnifiedEventLogEnums
local sendUnifiedEventLog = require(ServerDrivenUiParent.AvatarExperienceAnalytics).sendUnifiedEventLog
local UnifiedEventCounterAggregator = require(ServerDrivenUiParent.AvatarExperienceAnalytics).UnifiedEventCounterAggregator
local AXUnifiedEventFilter = require(ServerDrivenUiParent.AvatarExperienceAnalytics).AXUnifiedEventFilter
local FFlagAXUnifiedEventCounters = require(ServerDrivenUiParent.AvatarExperienceAnalytics).Flags.FFlagAXUnifiedEventCounters

local FFlagAXUnifiedEventStrictPayloads = require(ServerDrivenUiParent.AvatarExperienceAnalytics).Flags.FFlagAXUnifiedEventStrictPayloads

local AvatarScreen = require(ServerDrivenUiParent.AvatarExperienceNavigation).Enums.AvatarScreen
local UnifiedLoggingSurface = require(ServerDrivenUiParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface
local NavigationRodux = require(ServerDrivenUiParent.NavigationRodux)
local RobloxAppEnums = require(ServerDrivenUiParent.RobloxAppEnums)

local NavigateDown = NavigationRodux.Thunks.NavigateDown
local AppPage = RobloxAppEnums.AppPage

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors

local AnalyticsService = require(ServerDrivenUiParent.AvatarExperienceAnalytics).AnalyticsService
local ImpressionEnums = require(ServerDrivenUiParent.AvatarExperienceAnalytics).Enums.ImpressionEnums

local SharedFlags = require(ServerDrivenUiParent.SharedFlags)
local FFlagAXEnableHomeTryOnComplexView = SharedFlags.FFlagAXEnableHomeTryOnComplexView
local FFlagAXFixHomeAvatarsUnifiedPurchase = SharedFlags.FFlagAXFixHomeAvatarsUnifiedPurchase
local FFlagAXDiscoveryItemPurchaseAttribution = SharedFlags.FFlagAXDiscoveryItemPurchaseAttribution
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ServerDrivenUiParent.RobloxAppNavigation).NavigationCommands else nil
local bool1 = game:DefineFastFlag("AXFixHomepageTryOnScreenAnalytics", false)

local tbl1 = {
    [AppPage.Home] = ImpressionEnums.MarketplaceSurfaceType.DISCOVERY_HOMEPAGE,
    [AppPage.SearchPage] = ImpressionEnums.MarketplaceSurfaceType.DISCOVERY_SEARCH_RESULTS
}

local tbl2 = {
    [AppPage.Home] = UnifiedLoggingSurface.DISCOVERY_HOMEPAGE,
    [AppPage.SearchPage] = UnifiedLoggingSurface.DISCOVERY_SEARCH_RESULTS
}

local function reportOpenMarketplaceTryOnPropError(arg1, message: string, propName: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl3 = {
        name = SduiActionType.OpenMarketplaceTryOn,
        message = message
    }

    if propName ~= nil then
        tbl3.propName = propName
    end

    arg1.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, tbl3, arg1.appPage)
end

return function(arg1, arg2, arg3)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        reportOpenMarketplaceTryOnPropError(arg3, "Missing actionParams", nil)
        return
    end

    assert(actionParams, "actionParams must exist")

    local itemId = actionParams.itemId
    local str1 = tostring(itemId)
    if itemId == nil then
        local message = `Missing itemId: {str1}`
        local tbl3 = {
            name = SduiActionType.OpenMarketplaceTryOn,
            message = message
        }

        tbl3.propName = "itemId"

        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, tbl3, arg3.appPage)

        return
    end

    local str2 = tostring(actionParams.itemType)
    if str2 ~= "Asset" and str2 ~= "Bundle" and str2 ~= "Look" then
        local message = `Invalid itemType: {str2}`
        local tbl3 = {
            name = SduiActionType.OpenMarketplaceTryOn,
            message = message
        }

        tbl3.propName = "itemType"

        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, tbl3, arg3.appPage)

        return
    end

    local itemType = if str2 == "Asset" then UnifiedEventLogEnums.MarketplaceUnifiedItemType.ASSET elseif str2 == "Bundle" then UnifiedEventLogEnums.MarketplaceUnifiedItemType.BUNDLE elseif str2 == "Look" then UnifiedEventLogEnums.MarketplaceUnifiedItemType.LOOK else UnifiedEventLogEnums.MarketplaceUnifiedItemType.UNDEFINED_ITEM_TYPE
    local itemSubTypeName = actionParams.itemSubTypeName
    if (str2 == "Asset" or str2 == "Bundle") and itemSubTypeName == nil then
        local message = `Missing itemSubTypeName: {itemSubTypeName}`
        local tbl3 = {
            name = SduiActionType.OpenMarketplaceTryOn,
            message = message
        }

        tbl3.propName = "itemSubTypeName"

        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, tbl3, arg3.appPage)

        return
    end

    local itemPrice = if FFlagAXUnifiedEventCounters then tonumber(actionParams.itemPrice) else actionParams.itemPrice

    if itemPrice == nil then
        local message = `Missing itemPrice: {itemPrice}`
        local tbl3 = {
            name = SduiActionType.OpenMarketplaceTryOn,
            message = message
        }

        tbl3.propName = "itemPrice"

        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, tbl3, arg3.appPage)
    end

    local detail = str2 .. str1

    local var2 = tbl2[arg3.appPage]

    local var3 = FFlagAXFixHomeAvatarsUnifiedPurchase
        and {
            widgetId = findAnalyticsFieldInAncestors("widgetId", arg2),
            widgetType = findAnalyticsFieldInAncestors("widgetType", arg2),
            widgetItemIds = findAnalyticsFieldInAncestors("widgetItemIds", arg2),
            requestId = findAnalyticsFieldInAncestors("requestId", arg2),
            itemPosition = findAnalyticsFieldInAncestors("itemPosition", arg2)
        }
        or nil

    local str4 = "TryOnScreen"

    local surface = tbl1[arg3.appPage]

    if surface == nil then
        arg3.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenMarketplaceTryOn,
            message = `Unsupported appPage for OpenMarketplaceTryOn action: {arg3.appPage}`
        }, arg3.appPage)
    else
        local tbl3 = {
            actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
            group = "AvatarItemWidgetClick",
            surface = surface,
            item_id = itemId,
            item_type = str2
        }
        if not bool1 and arg3.appPage == AppPage.Home then
            tbl3 = {
                actionType = ImpressionEnums.ActionType.UI_BUTTON_CLICK,
                group = "HomePageAvatarWidgetClick",
                surface = ImpressionEnums.MarketplaceSurfaceType.HOMEPAGE,
                item_id = itemId,
                item_type = str2
            }
            str4 = "HomeTryOnScreen"
        end

        tbl3.event_sender_api = ImpressionEnums.MarketplaceEventSenderAPI.SEND_ROBLOX_TELEMETRY_EVENT
        AnalyticsService.EventStream:sendTelemetryEvent(str4, "marketplaceOrganicFELog", tbl3)
        local tbl4

        if FFlagAXFixHomeAvatarsUnifiedPurchase then
            local bool2 = not (var3.widgetId == nil or var3.widgetType == nil or var3.widgetItemIds == nil) and var3.requestId ~= nil
            tbl4 = {
                action = UnifiedEventLogEnums.MarketplaceUnifiedAction.ITEM_SELECTED,
                surface = var2,
                itemId = 0,
                itemType = 0
            }

            if FFlagAXUnifiedEventStrictPayloads then
                itemId = str1
            end

            tbl4.itemId = itemId
            tbl4.itemType = itemType

            if bool2 then
                local widgetId = if FFlagAXUnifiedEventStrictPayloads then tostring(var3.widgetId) else var3.widgetId
                tbl4.widgetId = widgetId
                local widgetType = if FFlagAXUnifiedEventStrictPayloads then tostring(var3.widgetType) else var3.widgetType
                tbl4.widgetType = widgetType
                local widgetItemIds = if FFlagAXUnifiedEventStrictPayloads then tostring(var3.widgetItemIds) else var3.widgetItemIds
                tbl4.widgetItemIds = widgetItemIds
                local requestId = if FFlagAXUnifiedEventStrictPayloads then tostring(var3.requestId) else var3.requestId
                tbl4.requestId = requestId

                tbl4.uiTreatmentType = UnifiedEventLogEnums.WidgetUiTreatment.ITEM_GROUP
                tbl4.widgetItemPrice = itemPrice
            else
                tbl4.organicItemPrice = itemPrice
            end
        else
            tbl4 = {
                action = UnifiedEventLogEnums.MarketplaceUnifiedAction.ITEM_SELECTED,
                surface = UnifiedLoggingSurface.DISCOVERY_HOMEPAGE,
                itemId = itemId,
                itemType = itemType,
                widgetId = "DiscoveryHomepageAvatarWidget:1234",
                widgetType = "DiscoveryHomepageAvatarWidget",
                uiTreatmentType = UnifiedEventLogEnums.WidgetUiTreatment.ITEM_GROUP,
                widgetItemPrice = itemPrice
            }
        end

        if FFlagAXDiscoveryItemPurchaseAttribution then
            sendUnifiedEventLog(tbl4)
        else
            if FFlagAXUnifiedEventCounters then
                UnifiedEventCounterAggregator.record(tbl4, AXUnifiedEventFilter.filter(tbl4, { skipReporting = true }))
            end

            AnalyticsService.EventStream:sendTelemetryEvent(
                UnifiedEventLogConstants.EVENT_NAME,
                UnifiedEventLogConstants.EVENT_NAME,
                tbl4
            )
        end
    end

    local tbl3 = {
        name = AppPage.AvatarExperienceWrapper,
        detail = detail,
        extraProps = 0
    }
    local extraProps = {
        routeName = AvatarScreen.TryOnItem,
        params = 0
    }
    local params = {
        itemId = str1,
        itemType = str2,
        itemSubTypeName = 0,
        mountAsFullView = false,
        mountAnimation = true,
        showRobuxBalance = true,
        showDropDownTopBar = true,
        fromSurface = 0,
        detail = 0,
        hideTab = true,
        simpleView = 0,
        shouldNavigateDown = true,
        avatarUnifiedAttribution = 0
    }

    if str2 == "Look" then
        itemSubTypeName = nil
    end

    params.itemSubTypeName = itemSubTypeName

    params.fromSurface = var2
    params.detail = detail

    params.simpleView = arg3.appPage == AppPage.Home and not FFlagAXEnableHomeTryOnComplexView

    if not FFlagAXFixHomeAvatarsUnifiedPurchase then
        var3 = nil
    end

    params.avatarUnifiedAttribution = var3
    extraProps.params = params
    tbl3.extraProps = extraProps

    if FFlagSignalsNavP3Dispatch then
        NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl3))
        return
    end
    arg3.dependencies.dispatch(NavigateDown(tbl3))
end
