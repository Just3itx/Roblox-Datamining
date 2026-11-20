-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2Wizard = script:FindFirstAncestor("AmpV2Wizard")
local AmpV2WizardParent = AmpV2Wizard.Parent

local LoggingProtocol = require(AmpV2WizardParent.LoggingProtocol)

local _Types = require(AmpV2Wizard.Types)
local WizardEventNames = require(AmpV2Wizard.WizardEventNames)

local throttlingPercentage = game:DefineFastInt("AmpV2WizardEventThrottleHundredthsPercent", 10000)

local function flattenParams(arg1)
    local result = ({})
    if arg1 == nil then
        return result
    end
    for value, value2 in arg1 do
        local str1 = type(value2)
        if str1 == "string" or str1 == "number" or str1 == "boolean" then
            result[value] = value2
        end
    end
    return result
end

local function makeConfig(eventName: string)
    return {
        eventName = eventName,
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 2026, 8, 19 },
        description = "AMP v2 wizard funnel events"
    }
end

local function createSendWizardEvent(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(eventName: string, arg2)
        arg1:logRobloxTelemetryEvent(makeConfig(eventName), nil, flattenParams(arg2), WizardEventNames.CONTEXT)
    end
end

return {
    flattenParams = flattenParams,
    createSendWizardEvent = createSendWizardEvent,
    default = createSendWizardEvent(LoggingProtocol.default)
}
