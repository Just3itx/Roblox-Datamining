-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local EventIngestService = game:GetService("EventIngestService")
local eventIngest = dependencies.Analytics.AnalyticsReporters.EventIngest.new(EventIngestService)
local Logging = dependencies.Logging
local scriptParentParentParent = scriptParentParent.Parent
local SharedFlags = require(scriptParentParentParent.SharedFlags)
local EventStreamConstants = require(scriptParentParent.Constants.EventStreamConstants)
local FFlagEnableAuthAnalyticsPrintDebuggingDev = SharedFlags.FFlagEnableAuthAnalyticsPrintDebuggingDev

return function(str1: string, str2: string, tbl1)
    local tbl2 = ({})
    local osClock = EventStreamConstants.EventTimingKeys.OsClock
    tbl1[osClock] = tostring(os.clock())
    local osTime = EventStreamConstants.EventTimingKeys.OsTime
    tbl1[osTime] = tostring(os.time())
    for k, value in pairs(tbl1) do
        if type(k) ~= "string" then
            Logging.warn("Failure logging " .. str2 .. ": Expected " .. k .. " to be a string key but got " .. type(k))

            return
        end

        tbl2[k] = value
    end

    if FFlagEnableAuthAnalyticsPrintDebuggingDev then
        local str3 = ""
        for k, value in pairs(tbl2) do
            str3 ..= k .. ": " .. tostring(value) .. ", "
        end
        local str4 = string.sub(str3, 1, -3)
        print("Emitting EventIngest " .. str2 .. ", context " .. str1 .. " with args: " .. str4)
    end

    eventIngest:sendEventDeferred(str1, str2, tbl2)
end
