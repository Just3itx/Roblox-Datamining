-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local TelemetryService = game:GetService("TelemetryService")

local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local React = require(HomeParent.React)
local getSduiApiStore = require(HomeParent.SduiSharedUtilities).getSduiApiStore

local HomeConstants = require(Home.HomeConstants)

local tbl1 = { 3, 10 }
local config = {
    eventName = "sduiHomeStartupSnapshot",
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("SduiHomeStartupSnapshotHundredthsPercent", 10000),
    lastUpdated = { 26, 11, 12 },
    description = "SDUI Home feed, mount and selection state shortly after Home mounts"
}

local function getSelectionBucket(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local guiObject = GuiService.SelectedCoreObject or GuiService.SelectedObject
    return if guiObject == nil then "none" elseif arg1 and guiObject:IsDescendantOf(arg1) then "home" else "outside"
end

local function getSelectableBucket(arg1)
    if arg1 == nil then
        return "noFrame"
    end
    local num1 = 0
    for _, descendant in arg1:GetDescendants() do
        if not (descendant:IsA("GuiObject") and descendant.Selectable and descendant.Visible) then
            continue
        end

        num1 += 1
        if num1 >= 6 then
            return "6+"
        end
    end

    return if num1 == 0 then "0" else "1-5"
end

local function logSnapshot(stage: string, arg1, tbl2)
    local sduiApiStore = getSduiApiStore()
    local configKey = HomeConstants.ConfigKey
    local var1 = sduiApiStore.getData(configKey).status(false)
    local telemetryService = TelemetryService
    local config2 = config
    local tbl3 = { customFields = 0, standardizedFields = 0 }
    local customFields = {
        stage = stage,
        status = if var1 ~= "Ready" and var1 ~= "NotReady" and var1 ~= "Failed" then "unknown" else var1,
        hasRoot = tostring(sduiApiStore.getRootConfig(configKey, false, HomeConstants.FeedEntryCacheKey) ~= nil),
        inFlight = tostring(sduiApiStore.isInFlight(configKey)),
        navFocused = if tbl2 then tostring(tbl2.isFocused()) else "unknown",
        selection = getSelectionBucket(arg1),
        selectables = getSelectableBucket(arg1)
    }
    tbl3.customFields = customFields

    tbl3.standardizedFields = { "addSessionInfo", "addOSInfo" }
    telemetryService:LogEvent(config2, tbl3)
end

local function useHomeStartupSnapshot(current, current2)
    local var1 = React.useRef(current)
    var1.current = current
    local var2 = React.useRef(current2)
    var2.current = current2

    React.useEffect(function()
        local tbl2 = ({})
        for value, value2 in tbl1 do
            tbl2[value] = task.delay(value2, function()
                tbl2[value] = nil
                pcall(logSnapshot, `{value2}s`, var1.current, var2.current)
            end)
        end

        return function()
            for _, value in tbl2 do
                task.cancel(value)
            end
        end
    end, {})
end

return useHomeStartupSnapshot
