-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PageLoadTrackerParent = script:FindFirstAncestor("PageLoadTracker").Parent
local LoggingProtocol = require(PageLoadTrackerParent.LoggingProtocol)
local PageLoadConfig = require(script.Parent.PageLoadConfig)

local _PageLoadTypes = require(script.Parent.PageLoadTypes)

local default = LoggingProtocol.default

function recordMilestone(arg1)
    default:logRobloxTelemetryEvent(PageLoadConfig.PAGE_LOAD_SUMMARY_CONFIG, { default.StandardizedFields.addOsInfo }, arg1)
end

return recordMilestone
