-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local TelemetryService = require(scriptParentParentParent.MockableProxyServices).TelemetryService
local _Placement = require(scriptParentParent.Enum.Placement)
local DeviceTier = require(scriptParentParentParent.Devices).DeviceTier

local bool1 = game:DefineFastFlag("AppNavDeviceTier", false)
local FFlagAppNavTelemetryLogger = require(scriptParentParentParent.SharedFlags).FFlagAppNavTelemetryLogger

local var1 = if FFlagAppNavTelemetryLogger then require(scriptParentParentParent.Loggers).Logger:new("AppNavTelemetry") else nil

local standardizedFields = { "addOSInfo", "addSessionId", "addSessionInfo" }
local deviceMemoryTier = if bool1 then DeviceTier.GetDeviceMemoryTier() else nil
local tbl2 = {
    eventName = "AppNav_SwitchTab",
    backends = { "RobloxTelemetryStat" },
    throttlingPercentage = 10000,
    lastUpdated = { 2026, 3, 12 },
    description = "App Nav switch tab",
    links = "https://roblox.atlassian.net/wiki/x/1ACaAQE"
}

local tbl3 = {
    eventName = "AppNav_SwitchTab",
    backends = { "EventIngest" },
    throttlingPercentage = 10000,
    lastUpdated = { 2026, 3, 12 },
    description = "App Nav switch tab",
    links = "https://roblox.atlassian.net/wiki/x/1ACaAQE"
}

local tbl4 = {
    eventName = "AppNav_IsVisibleChanged",
    backends = { "RobloxTelemetryStat" },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 3, 17 },
    description = "App Nav isVisible prop changed",
    links = "https://roblox.atlassian.net/wiki/x/1ACaAQE"
}

local tbl5 = {
    eventName = "AppNav_IsVisibleChanged",
    backends = { "EventIngest" },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 3, 17 },
    description = "App Nav isVisible prop changed",
    links = "https://roblox.atlassian.net/wiki/x/1ACaAQE"
}

local tbl6 = {
    eventName = "AppNav_PlacementChanged",
    backends = { "RobloxTelemetryCounter" },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 3, 17 },
    description = "App Nav placement prop changed",
    links = "https://roblox.atlassian.net/wiki/x/1ACaAQE"
}

local var2 = nil

local function logSwitchTabStart(previousPage: string, nextPage: string)
    var2 = {
        previousPage = previousPage,
        nextPage = nextPage,
        startTime = os.clock()
    }
end

local function reportSwitchTab(previousPage: string, currentPage: string, duration: number)
    TelemetryService:LogStat(tbl2, {
        customFields = {
            previous_page = previousPage,
            current_page = currentPage,
            device_tier = if bool1 then deviceMemoryTier else nil
        }
    }, duration)

    TelemetryService:LogEvent(tbl3, {
        customFields = {
            previous_page = previousPage,
            current_page = currentPage,
            duration = duration
        },
        standardizedFields = standardizedFields
    })
    if FFlagAppNavTelemetryLogger then
        var1:info(
            "AppNav switch_tab previous={} current={} duration_ms={} device_tier={}",
            tostring(previousPage),
            tostring(currentPage),
            string.format("%.2f", duration),
            tostring(deviceMemoryTier)
        )
    end
end

local function logSwitchTabEnd(nextPage: string)
    if not var2 then
        return
    end

    if nextPage ~= var2.nextPage then
        var2 = nil
    else
        local previousPage = var2.previousPage
        local var3 = (os.clock() - var2.startTime) * 1000
        var2 = nil
        reportSwitchTab(previousPage, nextPage, var3)
    end
end

local var3 = nil

local function logVisibilityStart(nextValue: boolean)
    var3 = {
        nextValue = nextValue,
        startTime = os.clock()
    }
end

local function reportVisibility(isVisible: boolean, duration: number)
    TelemetryService:LogStat(
        tbl4,
        {
            customFields = {
                is_visible = isVisible,
                device_tier = if bool1 then deviceMemoryTier else nil
            }
        },
        duration
    )

    TelemetryService:LogEvent(
        tbl5,
        {
            customFields = { is_visible = isVisible, duration = duration },
            standardizedFields = standardizedFields
        }
    )

    if FFlagAppNavTelemetryLogger then
        var1:info(
            "AppNav is_visible_changed is_visible={} duration_ms={} device_tier={}",
            tostring(isVisible),
            string.format("%.2f", duration),
            tostring(deviceMemoryTier)
        )
    end
end

local function logVisibilityEnd(nextValue: boolean)
    if not var3 then
        return
    end

    if nextValue ~= var3.nextValue then
        var3 = nil
    else
        local var4 = (os.clock() - var3.startTime) * 1000
        var3 = nil
        reportVisibility(nextValue, var4)
    end
end

local currentCurrentPlacement = nil

return {
    logSwitchTabStart = logSwitchTabStart,
    logSwitchTabEnd = logSwitchTabEnd,
    logVisibilityStart = logVisibilityStart,
    logVisibilityEnd = logVisibilityEnd,
    logPlacement = function(currentPlacement)
        if currentPlacement == currentCurrentPlacement then
            return
        end
        TelemetryService:LogCounter(
            tbl6,
            {
                customFields = {
                    previous_placement = currentCurrentPlacement,
                    current_placement = currentPlacement
                }
            }
        )

        if FFlagAppNavTelemetryLogger then
            var1:info(
                "AppNav placement_changed previous={} current={}",
                tostring(currentCurrentPlacement),
                tostring(currentPlacement)
            )
        end

        currentCurrentPlacement = currentPlacement
    end,
    reset = function()
        var2 = nil
        var3 = nil
        currentCurrentPlacement = nil
    end
}
