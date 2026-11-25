-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local findAnalyticsFieldInAncestors = require(SduiCoreSystem.findAnalyticsFieldInAncestors)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)

local function getActionTelemetryFieldValue(arg1, arg2, str1: string, arg3)
    local analyticsFieldInAncestors = findAnalyticsFieldInAncestors(str1, arg2)
    if analyticsFieldInAncestors ~= nil then
        return analyticsFieldInAncestors
    end

    if arg1 then
        local actionParams = arg1.actionParams
        if actionParams and actionParams[str1] ~= nil then
            return actionParams[str1]
        end
    end

    return arg3
end

return getActionTelemetryFieldValue
