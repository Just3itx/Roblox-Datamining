-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local LoggingProtocol = require(FlyoutSidePanelParent.LoggingProtocol)

local FlyoutContentSettings = require(script.Parent.Parent.Config.FlyoutContentSettings)

local default = LoggingProtocol.default

local bool1 = game:DefineFastFlag("FlyoutRemoveAddSessionInfo", false)

local tbl1 = {
    eventName = "coreui_flyout_side_panel_open",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("FlyoutSidePanelOpenEventThrottleHunderedthsPercent", 10000),
    lastUpdated = { 2025, 10, 30 },
    description = "FlyoutSidePanel open event, source can be Home, Chat, or Charts",
    links = "https://roblox.atlassian.net/browse/APPEXP-3739"
}

local tbl2 = {
    eventName = "coreui_flyout_side_panel_close",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("FlyoutSidePanelCloseEventThrottleHunderedthsPercent", 10000),
    lastUpdated = { 2025, 10, 30 },
    description = "FlyoutSidePanel close event, source can be click, swipe, or shield",
    links = "https://github.rbx.com/Roblox/proto-schemas/pull/8500"
}

local tbl3 = {
    eventName = "coreui_flyout_tooltip_show",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("FlyoutTooltipShowEventThrottleHunderedthsPercent", 10000),
    lastUpdated = { 2026, 1, 21 },
    description = "Flyout tooltip show event",
    links = "https://github.rbx.com/Roblox/proto-schemas/pull/9318"
}

local tbl4 = {
    eventName = "coreui_flyout_tooltip_dismiss",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("FlyoutTooltipDismissEventThrottleHunderedthsPercent", 10000),
    lastUpdated = { 2025, 10, 30 },
    description = "Flyout tooltip dismiss event, source can be click or shield",
    links = "https://github.rbx.com/Roblox/proto-schemas/pull/8500"
}

local tbl5 = {
    eventName = "coreui_flyout_content_item_click",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("FlyoutContentItemClickEventThrottleHunderedthsPercent", 10000),
    lastUpdated = { 2025, 10, 30 },
    description = "FlyoutSidePanel content item click event",
    links = "https://github.rbx.com/Roblox/proto-schemas/pull/8500"
}

local tbl6 = {
    eventName = "coreui_flyout_content_item_impression",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("FlyoutContentItemImpressionEventThrottleHunderedthsPercent", 10000),
    lastUpdated = { 2026, 9, 3 },
    description = "FlyoutSidePanel content item impression event",
    links = "https://roblox.atlassian.net/browse/MKTUJ-5174"
}

local tbl7 = {
    eventName = "coreui_flyout_switch_account_click",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("FlyoutSwitchAccountClickEventThrottleHunderedthsPercent", 10000),
    lastUpdated = { 2026, 11, 5 },
    description = "Flyout switch account click",
    links = ""
}

local function checkEventNameMappings(str1: string?) -- Luacid: unused: defined but never referenced
    return if str1 and FlyoutContentSettings.EventNameMappings[str1] then FlyoutContentSettings.EventNameMappings[str1] else str1 or ""
end

local function logEventHelper(tbl8: {backends: {string}, description: string, eventName: string, lastUpdated: {number}, links: string, throttlingPercentage: number}, str1: string, tbl9)
    local tbl10 = bool1 and {
        "addPlaceId",
        "addUniverseId",
        "addPlaceInstanceId",
        "addSessionId",
        "addOsInfo"
    }
        or {
            "addPlaceId",
            "addUniverseId",
            "addPlaceInstanceId",
            "addSessionId",
            "addSessionInfo",
            "addOsInfo"
        }

    local integrationId = tbl9.integrationId
    local tbl11 = {
        integration_id = not integrationId and (integrationId or "")
            or not FlyoutContentSettings.EventNameMappings[integrationId] and (integrationId or "")
            or FlyoutContentSettings.EventNameMappings[integrationId],
        source = tbl9.source,
        local_timestamp = os.time(),
        count = tbl9.count
    }
    default:logRobloxTelemetryEvent(tbl8, tbl10, tbl11, str1)
end

local function onFlyoutSidePanelClosed(tbl8) -- Luacid: Inlined by compiler; 2 call sites recovered
    logEventHelper(tbl2, "flyout_close", tbl8)
end

local function onFlyoutContentItemClicked(tbl8) -- Luacid: Inlined by compiler; 1 call site recovered
    logEventHelper(tbl5, "flyout_item_click", tbl8)
    onFlyoutSidePanelClosed(tbl8)
end

local function sendMoreGridItemClickEvent_legacy(arg1, itemType, localUserId, url) -- Luacid: Inlined by compiler; 1 call site recovered
    arg1:setRBXEventStream(
        "moreGridItem",
        "moreGridItemClick",
        { itemType = itemType, localUserId = localUserId, url = url }
    )
end

return {
    onFlyoutSidePanelClosed = onFlyoutSidePanelClosed,
    onFlyoutTooltipShown = function(tbl8)
        logEventHelper(tbl3, "flyout_tooltip_show", tbl8)
    end,
    onFlyoutTooltipDismissed = function(tbl8)
        logEventHelper(tbl4, "flyout_tooltip_dismiss", tbl8)
    end,
    onFlyoutContentItemClicked = onFlyoutContentItemClicked,
    onFlyoutContentItemImpressed = function(tbl8)
        logEventHelper(tbl6, "flyout_item_impression", tbl8)
    end,
    onFlyoutSwitchAccountClicked = function(tbl8)
        logEventHelper(tbl7, "flyout_switch_account_click", tbl8)
    end,
    sendMoreLegacyAndFlyoutItemClickEvent = function(arg1, arg2, localUserId, url)
        local integrationId = not arg2 and (arg2 or "")
            or not FlyoutContentSettings.EventNameMappings[arg2] and (arg2 or "")
            or FlyoutContentSettings.EventNameMappings[arg2]

        onFlyoutContentItemClicked({ integrationId = integrationId, source = "click" })
        sendMoreGridItemClickEvent_legacy(arg1, integrationId, localUserId, url)
    end,
    sendPageLoadEvent = function(arg1, str1: string?)
        arg1:setRBXEventStream(
            "AppRouter",
            "luaPageLoad",
            {
                locale = LocalizationService.RobloxLocaleId,
                page = "more",
                rootPageTitle = str1
            }
        )
        logEventHelper(tbl1, "flyout_open", { source = str1 })
    end
}
