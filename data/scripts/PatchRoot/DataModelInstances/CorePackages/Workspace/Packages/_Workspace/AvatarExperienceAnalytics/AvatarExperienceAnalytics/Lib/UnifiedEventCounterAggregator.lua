-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local UnifiedEventLogEnums = require(script.Parent.Parent.UnifiedEventLogEnums)
local _UnifiedEventTypes = require(script.Parent.Parent.Generated.UnifiedEventTypes)
local MarketplaceUnifiedAction = UnifiedEventLogEnums.MarketplaceUnifiedAction
local MarketplaceUnifiedActionNumbers = UnifiedEventLogEnums.MarketplaceUnifiedActionNumbers
local sendAXCounterV2 = require(script.Parent.Parent.sendAXCounterV2)

local UnifiedLoggingSurface = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local isRunningInStudio = require(AvatarExperienceAnalyticsParent.AppCommonLib).isRunningInStudio

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local FIntAXUnifiedEventCounterFlushSeconds = AvatarExperienceFlags.FIntAXUnifiedEventCounterFlushSeconds

local FIntAXUnifiedEventCounterImpressionFlushSeconds = AvatarExperienceFlags.FIntAXUnifiedEventCounterImpressionFlushSeconds
local FIntAXUnifiedEventCounterMaxKeys = AvatarExperienceFlags.FIntAXUnifiedEventCounterMaxKeys
local FIntAXUnifiedEventCounterIdleSeconds = AvatarExperienceFlags.FIntAXUnifiedEventCounterIdleSeconds
local FFlagAXUnifiedEventCounterDebugLogs = AvatarExperienceFlags.FFlagAXUnifiedEventCounterDebugLogs
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads

local tbl1 = {
    [MarketplaceUnifiedAction.PURCHASE_ATTEMPT] = true,
    [MarketplaceUnifiedAction.PURCHASE_SUCCESS] = true
}

local tbl2 = {
    [MarketplaceUnifiedAction.ITEM_IMPRESSION] = true,
    [MarketplaceUnifiedAction.WIDGET_IMPRESSION] = true,
    [MarketplaceUnifiedAction.UI_ELEMENT_IMPRESSION] = true,
    [MarketplaceUnifiedAction.WIDGET_LOADED] = true
}

local module = {}

local function newWindow(label: string, maxSeconds: number, tracksPhase: boolean)
    return {
        label = label,
        maxSeconds = maxSeconds,
        buckets = {},
        keyCount = 0,
        pendingFlush = nil,
        recordCount = 0,
        armedAtCount = 0,
        waitedSeconds = 0,
        tracksPhase = tracksPhase
    }
end

local tbl3 = newWindow("short", FIntAXUnifiedEventCounterFlushSeconds, false)
local tbl4 = newWindow("long", FIntAXUnifiedEventCounterImpressionFlushSeconds, true)

local var1 = nil
local tbl5 = ({})

local function invertEnum(tbl6)
    local result = {}
    for value, value2 in tbl6 do
        result[tostring(value2)] = tostring(value)
    end
    return result
end

if not FFlagAXUnifiedEventStrictPayloads then
    MarketplaceUnifiedActionNumbers = MarketplaceUnifiedAction
end

local tbl6 = invertEnum(MarketplaceUnifiedActionNumbers)

local tbl7 = invertEnum(UnifiedLoggingSurface)

local function toDimensionString(str1: string?): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if str1 == nil or str1 == "" then
        return "Unknown"
    end
    return tostring(str1)
end

local function toElementNameDimension(elementName: string?)
    local str1 = toDimensionString(elementName)

    while true do
        local var2 = string.gsub(str1, "[_:%-]%d+$", "")
        if var2 == str1 or var2 == "" then
            break
        end

        str1 = var2
    end

    return str1
end

local function toEnumName(arg1, tbl8) -- Luacid: Inlined by compiler; 2 call sites recovered
    if FFlagAXUnifiedEventStrictPayloads then
        local str1 = if arg1 == nil then "" else tostring(arg1)
        return if str1 == "" then "Unknown" else tbl8[str1] or str1
    end
    if arg1 == nil or arg1 == "" then
        return "Unknown"
    end
    local str1 = tostring(arg1)
    return tbl8[str1] or str1
end

local function debugEnabled() -- Luacid: Inlined by compiler; 5 call sites recovered
    return FFlagAXUnifiedEventCounterDebugLogs and isRunningInStudio()
end

local function describe(tbl8): string
    return string.format(
        "action=%s surface=%s page=%s element=%s filterPass=%s",
        tbl8.action,
        tbl8.surface,
        tbl8.navigationPage,
        tbl8.elementName or "-",
        tbl8.filterPass or "-"
    )
end

local function bucketKey(tbl8): string
    return table.concat({ tbl8.action, tbl8.surface, tbl8.navigationPage, tbl8.elementName or "", tbl8.filterPass or "" }, "|")
end

local function peekPhase(str1: string): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return if tbl5[str1] then "Continued" else "Initial"
end

local function takePhase(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local str2 = peekPhase(str1)
    tbl5[str1] = true
    return str2
end

local function emit(tbl8, increment: number, phase: string?)
    local tbl9 = {
        action = tbl8.action,
        surface = tbl8.surface,
        navigationPage = tbl8.navigationPage
    }
    if tbl8.elementName ~= nil then
        tbl9.elementName = tbl8.elementName
    end
    if tbl8.filterPass ~= nil then
        tbl9.filterPass = tbl8.filterPass
    end
    if phase ~= nil then
        tbl9.phase = phase
    end

    if debugEnabled() then
        print(
            string.format("%s SEND increment=%d phase=%s %s", "[AXUnifiedEventCounters]", increment, phase or "-", describe(tbl8))
        )
    end

    sendAXCounterV2("AXUnifiedEventSent", tbl9, increment)
end

local function flushWindow(tbl8)
    if tbl8.pendingFlush ~= nil then
        task.cancel(tbl8.pendingFlush)
        tbl8.pendingFlush = nil
    end

    local buckets = tbl8.buckets
    local keyCount = tbl8.keyCount
    tbl8.buckets = {}
    tbl8.keyCount = 0
    tbl8.waitedSeconds = 0

    if debugEnabled() and keyCount > 0 then
        print(string.format("%s FLUSH %s %d key(s)", "[AXUnifiedEventCounters]", tbl8.label, keyCount))
    end

    for k, bucket in buckets do
        emit(bucket.dimensions, bucket.count, if tbl8.tracksPhase then takePhase(k) else nil)
    end
end

function module.flush()
    flushWindow(tbl3)
    flushWindow(tbl4)
end

local function scheduleFlush(tbl8)
    if tbl8.pendingFlush ~= nil then
        return
    end

    local idle = math.max(FIntAXUnifiedEventCounterIdleSeconds, 1)

    if debugEnabled() and tbl8.waitedSeconds == 0 then
        print(string.format("%s SCHEDULE %s idle=%ds max=%ds", "[AXUnifiedEventCounters]", tbl8.label, idle, tbl8.maxSeconds))
    end

    tbl8.armedAtCount = tbl8.recordCount
    tbl8.pendingFlush = task.delay(idle, function()
        tbl8.pendingFlush = nil
        local tbl9 = tbl8
        tbl9.waitedSeconds += idle

        local bool1 = tbl8.recordCount == tbl8.armedAtCount
        if not (bool1 or tbl8.waitedSeconds >= tbl8.maxSeconds) then
            scheduleFlush(tbl8)
            return
        end

        if debugEnabled() then
            print(
                string.format(
                    "%s CLOSE %s after %ds (%s)",
                    "[AXUnifiedEventCounters]",
                    tbl8.label,
                    tbl8.waitedSeconds,
                    if bool1 then "idle" else "max"
                )
            )
        end
        flushWindow(tbl8)
    end)
end

function module.record(arg1, bool1: boolean?)
    local action = arg1.action
    if action == nil then
        return
    end

    local var2 = arg1.navigationOpaquePage or arg1.navigationPage
    if var2 ~= nil and var2 ~= var1 then
        var1 = var2
        tbl5 = {}
    end

    local dimensions = {
        action = toEnumName(action, tbl6),
        surface = toEnumName(arg1.surface, tbl7),
        navigationPage = toDimensionString(arg1.navigationPage),
        elementName = if action == MarketplaceUnifiedAction.UI_ELEMENT_CLICK then toElementNameDimension(arg1.elementName) else nil,
        filterPass = if bool1 == nil then nil else tostring(bool1)
    }

    if tbl1[action] then
        emit(dimensions, 1)
        return
    end

    local tbl9 = if tbl2[action] then tbl4 else tbl3
    tbl9.recordCount += 1

    local str1 = bucketKey(dimensions)
    local bucket = tbl9.buckets[str1]
    if bucket == nil then
        tbl9.buckets[str1] = { dimensions = dimensions, count = 1 }
        tbl9.keyCount += 1

        if debugEnabled() then
            print(
                string.format(
                    "%s OPEN %s bucket (%d open) phase=%s %s",
                    "[AXUnifiedEventCounters]",
                    tbl9.label,
                    tbl9.keyCount,
                    if tbl9.tracksPhase then peekPhase(str1) else "-",
                    describe(dimensions)
                )
            )
        end
    else
        bucket.count += 1
    end

    if tbl9.keyCount >= FIntAXUnifiedEventCounterMaxKeys then
        flushWindow(tbl9)
        return
    end

    scheduleFlush(tbl9)
end

return module
